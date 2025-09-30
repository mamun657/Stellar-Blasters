import 'package:flutter/material.dart';

class RelocateScreen extends StatelessWidget {
  const RelocateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset("assets/ecocity.jpg", height: 28),
            const SizedBox(width: 6),
            const Text(
              "ecocity",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

    
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Relocate",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Some of your provided data will be considered for relocation purposes",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

      
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildIndex("Air Quality Index", "6.7"),
                _buildIndex("Water Quality Index", "9.6"),
                _buildIndex(
                    "Livability Score\nCurrent Location: Chattogram", "81",
                    isHighlight: true),
                _buildIndex("Green Space Index", "5.8"),
                _buildIndex("Safety Index", "9.8"),
                _buildIndex("Transport Index", "6.3"),
              ],
            ),

            const SizedBox(height: 24),

           
            const Row(
              children: [
                Icon(Icons.map, size: 22),
                SizedBox(width: 8),
                Text(
                  "Suggested Relocation Destination",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),

           
            _buildDestination("Textile, Oxygen, Chattogram", "80"),
            _buildDestination("Dampara, Mohammad Ali Road No. 1", "78"),
            _buildDestination("Halishahar, K-Block, Road-8", "75"),
            _buildDestination("Textile, Oxygen, Chattogram", "70"),
            _buildDestination("Dampara, Mohammad Ali Road No. 1", "65"),
            _buildDestination("Halishahar, K-Block, Road-8", "82"),
            const SizedBox(height: 80),
          ],
        ),
      ),

  
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Refreshing suggestions...")),
          );
        },
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }


  static Widget _buildIndex(String title, String value,
      {bool isHighlight = false}) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: isHighlight ? Colors.green.shade900 : Colors.green.shade700,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlight ? 26 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }


  static Widget _buildDestination(String title, String score) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Livability Score $score",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
