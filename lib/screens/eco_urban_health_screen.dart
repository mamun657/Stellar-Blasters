import 'package:flutter/material.dart';

class EcoUrbanHealthScreen extends StatefulWidget {
  const EcoUrbanHealthScreen({super.key});

  @override
  State<EcoUrbanHealthScreen> createState() => _EcoUrbanHealthScreenState();
}

class _EcoUrbanHealthScreenState extends State<EcoUrbanHealthScreen> {
  double _selectedYear = 2025;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar: back + logo + EcoSmart text
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/ecocity.jpg", height: 28),
            const SizedBox(width: 6),
            const Text(
              "EcoSmart",
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
            // Title + description
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

            // Card: date range slider + View button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // year marks
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("2025", style: TextStyle(color: Colors.black54)),
                      Text("2075", style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  Slider(
                    value: _selectedYear,
                    min: 2025,
                    max: 2075,
                    divisions: 50,
                    label: _selectedYear.round().toString(),
                    activeColor: Colors.green,
                    onChanged: (v) => setState(() => _selectedYear = v),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Viewing urban health data for ${_selectedYear.round()}",
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "View",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // What-If section
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

            // 2x3 grid of big round buttons
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _ScenarioButton(
                  icon: Icons.local_hospital,
                  label: "Add Hospital",
                ),
                _ScenarioButton(icon: Icons.alt_route, label: "Add Highway"),
                _ScenarioButton(icon: Icons.park, label: "Add Park"),
                _ScenarioButton(
                  icon: Icons.precision_manufacturing,
                  label: "Add Factory",
                ),
                _ScenarioButton(icon: Icons.home, label: "Add Housing"),
                _ScenarioButton(icon: Icons.eco, label: "Add Green Spaces"),
              ],
            ),

            const SizedBox(height: 24),

            // Add Simulation (big rounded)
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  "Add Simulation",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// one circular green icon + text
class _ScenarioButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ScenarioButton({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
