import 'package:flutter/material.dart';

class EcoUrbanHealthScreen extends StatefulWidget {
  const EcoUrbanHealthScreen({super.key});

  @override
  State<EcoUrbanHealthScreen> createState() => _EcoUrbanHealthScreenState();
}

class _EcoUrbanHealthScreenState extends State<EcoUrbanHealthScreen> {
  double _year = 2050;

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/ecocity.jpg", height: 28),
            const SizedBox(width: 8),
            const Text(
              "EcoSmart",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Urban Health",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Some of your provided data will be considered for producing Urban Health data.",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    "Use the slider to choose date range for visualizing urban health data",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text("2025"), Text("2075")],
                  ),
                  Slider(
                    value: _year,
                    min: 2025,
                    max: 2075,
                    divisions: 10,
                    label: _year.round().toString(),
                    onChanged: (value) {
                      setState(() => _year = value);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("View"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "What-If Scenario Builder",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Please select any scenario from the grid below to get the projected impact.",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _scenarioButton(Icons.local_hospital, "Add Hospital"),
                _scenarioButton(Icons.traffic, "Add Highway"),
                _scenarioButton(Icons.park, "Add Park"),
                _scenarioButton(Icons.factory, "Add Factory"),
                _scenarioButton(Icons.home, "Add Housing"),
                _scenarioButton(Icons.nature, "Add Green Spaces"),
              ],
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Add Simulation",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _scenarioButton(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
