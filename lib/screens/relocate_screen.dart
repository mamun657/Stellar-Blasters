import 'package:flutter/material.dart';

class RelocateScreen extends StatelessWidget {
  const RelocateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset("assets/ecocity.jpg", height: 32),
            const SizedBox(width: 8),
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
            const SizedBox(height: 4),
            const Text(
              "Some of your provided data will be considered for relocation purposes",
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // ✅ 6টি Circle Card দেখানোর Row
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 12,
              runSpacing: 12,
              children: [
                _circleStat("Air Quality Index", "6.7"),
                _circleStat("Water Quality Index", "9.6"),
                _circleStat(
                  "Livability Score\nCurrent Location\nChattogram",
                  "81",
                ),
                _circleStat("Green Space Index", "5.8"),
                _circleStat("Transport Index", "6.3"),
                _circleStat("Safety Index", "9.8"),
              ],
            ),

            const SizedBox(height: 30),

            // Suggested relocation
            const Text(
              "Suggested Relocation Destination",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _relocationCard("Textile, Oxygen, Chattogram", "80"),
            _relocationCard("Dampara, Mohammad Ali Road No. 1", "78"),
            _relocationCard("Halishahar, K-Block, Road-8", "75"),
            _relocationCard("Textile, Oxygen, Chattogram", "70"),
            _relocationCard("Dampara, Mohammad Ali Road No. 1", "65"),
            _relocationCard("Halishahar, K-Block, Road-8", "82"),
          ],
        ),
      ),
    );
  }

  // ✅ Circle Stat Widget
  static Widget _circleStat(String title, String value) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Relocation Suggestion Card
  static Widget _relocationCard(String place, String score) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              place,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            "Livability Score $score",
            style: const TextStyle(color: Colors.green, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
