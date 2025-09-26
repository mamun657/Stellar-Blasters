import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'predict_ai_screen.dart';

class EcoHomeScreen extends StatelessWidget {
  const EcoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        actions: const [
          Icon(Icons.settings, color: Colors.black87),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Abidur's Dash",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "South Khulshi, Chattogram, Bangladesh",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            _profileCard(),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _metricWhiteCard(
                    "Average Heart Rate This Week",
                    "85.7 BPS",
                    "assets/icons/heart.png",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _metricWhiteCard(
                    "Today's Step Count",
                    "3021 Steps",
                    "assets/icons/run.png",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            _metricGreenCard("Air Quality Index (AQI)", "7", Icons.air),
            const SizedBox(height: 12),
            _metricGreenCard("Solar Radiation", "3.5", Icons.wb_sunny),

            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "See All",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            _mapCard(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ), // index 0
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_rounded),
            label: "Alert",
          ), // index 1
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Location",
          ), // index 2
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "AI Predict",
          ), // index 3 (last / AI Predict)
        ],
        onTap: (index) {
          // open Predict AI page when user taps the last (fourth) button (index == 3)
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PredictAiScreen()),
            );
            return;
          }

          // TODO: add behaviour for other indexes (home, alert, location) as needed
        },
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
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
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  static Widget _metricWhiteCard(String title, String value, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 2)],
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 28, height: 28, color: Colors.green),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(value, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _mapCard() {
    final CameraPosition initial = CameraPosition(
      target: LatLng(22.3569, 91.7832),
      zoom: 13,
    );

    final Marker chattogramMarker = Marker(
      markerId: const MarkerId('chattogram'),
      position: const LatLng(22.3569, 91.7832),
      infoWindow: const InfoWindow(title: "South Khulshi, Chattogram"),
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 180,
          child: GoogleMap(
            initialCameraPosition: initial,
            markers: {chattogramMarker},
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {},
          ),
        ),
      ),
    );
  }
}
