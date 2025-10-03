import 'package:flutter/material.dart';

class EcoRouteScreen extends StatefulWidget {
  const EcoRouteScreen({super.key});

  @override
  State<EcoRouteScreen> createState() => _EcoRouteScreenState();
}

class _EcoRouteScreenState extends State<EcoRouteScreen> {
  String? startLocation;
  String? destination;

  final List<String> locations = [
    "WASA",
    "Station Road",
    "GEC",
    "Agrabad",
    "Airport",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset("assets/ecocity.jpg", height: 28),
            const SizedBox(width: 6),
            const Text("ecocity", style: TextStyle(color: Colors.green)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Eco Route",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Data-powered routes for cleaner air and smarter living",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Starting location
            DropdownButtonFormField<String>(
              value: startLocation,
              hint: const Text("Starting Location"),
              items: locations.map((loc) {
                return DropdownMenuItem(value: loc, child: Text(loc));
              }).toList(),
              onChanged: (value) => setState(() => startLocation = value),
              decoration: _dropdownDecoration(),
            ),
            const SizedBox(height: 20),

            const Center(child: Icon(Icons.swap_vert, size: 32)),

            // Destination
            DropdownButtonFormField<String>(
              value: destination,
              hint: const Text("Destination"),
              items: locations.map((loc) {
                return DropdownMenuItem(value: loc, child: Text(loc));
              }).toList(),
              onChanged: (value) => setState(() => destination = value),
              decoration: _dropdownDecoration(),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (startLocation != null && destination != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Best eco route from $startLocation to $destination",
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Result",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.green.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.green.shade200),
      ),
    );
  }
}
