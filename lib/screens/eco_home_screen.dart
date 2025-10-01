import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'predict_ai_screen.dart';
import '../services/auth_service.dart';
import 'eco_urban_health_screen.dart';
import 'relocate_screen.dart';

class EcoHomeScreen extends StatefulWidget {
  const EcoHomeScreen({super.key});

  @override
  State<EcoHomeScreen> createState() => _EcoHomeScreenState();
}

class _EcoHomeScreenState extends State<EcoHomeScreen> {
  int _selectedIndex = 0;

 
  void _onNavTap(int index) {
    if (index == 1) {
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RelocateScreen()),
      );
      return;
    }
    if (index == 2) {
     
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EcoUrbanHealthScreen()),
      );
      return;
    }
    if (index == 4) {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PredictAiScreen()),
      );
      return;
    }

    
    setState(() => _selectedIndex = index);
  }

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
            const SizedBox(height: 18),

           
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

            const SizedBox(height: 18),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "See All",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            _mapCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),

    
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  
  Widget _buildBottomNav() {
    return Material(
      elevation: 8,
      color: Colors.green[200],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(
              Icons.home,
              "Home",
              _selectedIndex == 0,
              () => _onNavTap(0),
            ),
            _navItem(
              Icons.route_rounded,
              "Relocate",
              _selectedIndex == 1,
              () => _onNavTap(1),
            ),
            _navItem(
              Icons.warning_amber_rounded,
              "Urban H",
              _selectedIndex == 2,
              () => _onNavTap(2),
            ),
            _navItem(
              Icons.location_on,
              "Navigation",
              _selectedIndex == 3,
              () => _onNavTap(3),
            ),
            _navItem(
              Icons.smart_toy,
              "AI Predict",
              _selectedIndex == 4,
              () => _onNavTap(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: selected
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.black87 : Colors.white70),
            const SizedBox(width: 6),
            if (selected)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }


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
                      _infoColumn("Residence", "South Khulshi", Colors.black87),
                      const SizedBox(width: 12),
                      _infoColumn("Member Since", "2023", Colors.black87),
                      const SizedBox(width: 12),
                      _infoColumn("Score", "84", Colors.green),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 6),
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


  static Widget _alertCard({
    required String title,
    required String value,
    required String sub,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
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

  
  static Widget _metricGreenCard(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green.shade900, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  static Widget _mapCard() {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 180,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(22.3569, 91.7832),
                  zoom: 13,
                ),
                markers: {
                  const Marker(
                    markerId: MarkerId('chattogram'),
                    position: LatLng(22.3569, 91.7832),
                    infoWindow: InfoWindow(title: "South Khulshi, Chattogram"),
                  ),
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
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
