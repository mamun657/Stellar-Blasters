import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/auth_service.dart';
import 'eco_urban_health_screen.dart';
import 'ai_chat_screen.dart';

class EcoHomeScreen extends StatelessWidget {
  const EcoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🟢 AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset("assets/ecocity.jpg", height: 32),
            const SizedBox(width: 8),
            const Text(
              "Eco City",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () async {
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
          const SizedBox(width: 16),
        ],
      ),

      // 🟢 Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Abidur's Dash",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "South Khulshi, Chattogram, Bangladesh",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            _profileCard(),
            const SizedBox(height: 16),

            // Heart rate + Steps
            Row(
              children: [
                Expanded(
                  child: _metricCard(
                    title: "Average Heart Rate This Week",
                    value: "85.7 BPS",
                    color: Colors.black,
                    valueColor: Colors.amber,
                    icon: Icons.favorite,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _metricCard(
                    title: "Today's Step Count",
                    value: "3021 Steps",
                    color: Colors.black,
                    valueColor: Colors.orange,
                    icon: Icons.directions_walk,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Alerts
            Row(
              children: [
                Expanded(
                  child: _alertCard(
                    title: "Water Level",
                    value: "1.3",
                    sub: "No risk of drought",
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _alertCard(
                    title: "Current Temp",
                    value: "40°C",
                    sub: "Extreme heat alert",
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _metricGreenCard("Air Quality Index (AQI)", "7", Icons.air),
            const SizedBox(height: 12),
            _metricGreenCard("Solar Radiation", "3.5", Icons.wb_sunny),
            const SizedBox(height: 12),
            _metricGreenCard("CO2 Emission Avoided", "125.3 gm/day", Icons.eco),

            const SizedBox(height: 16),

            _mapCard(),
          ],
        ),
      ),

      // 🟢 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Home selected by default
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
        onTap: (i) {
          if (i == 0) {
            // Already Home
          } else if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EcoUrbanHealthScreen()),
            );
          } else if (i == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AIChatScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: "Relocate",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: "Urban H",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: "Navigation",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "AI Predict"),
        ],
      ),
    );
  }

  // ---------------- Profile Card ----------------
  static Widget _profileCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage("assets/ecocity.jpg"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Abidur Chowdhury",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoColumn("Eco Score", "100,000 pts", Colors.green),
                      _infoColumn("Leader Board", "1", Colors.black),
                      _infoColumn("Eco Coins", "1M", Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoColumn(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // ---------------- Metrics Card ----------------
  static Widget _metricCard({
    required String title,
    required String value,
    required Color color,
    required Color valueColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Alert Card ----------------
  static Widget _alertCard({
    required String title,
    required String value,
    required String sub,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1), // ✅ fixed
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // ---------------- Green Metrics ----------------
  static Widget _metricGreenCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Map Card ----------------
  static Widget _mapCard() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(22.3569, 91.7832),
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("chattogram"),
                  position: const LatLng(22.3569, 91.7832),
                  infoWindow: const InfoWindow(
                    title: "South Khulshi, Chattogram",
                  ),
                ),
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              MapStatCard("65/100", "Livability Score", Colors.orange),
              MapStatCard("2035", "Habitable Until", Colors.black),
              MapStatCard("500", "Need to plant", Colors.green),
            ],
          ),
        ),
      ],
    );
  }
}

// ✅ Small widget for stats under the map
class MapStatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const MapStatCard(this.value, this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}
