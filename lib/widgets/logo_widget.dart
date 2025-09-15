import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/ecocity.jpg", // ensure this path matches your asset
          height: 150, // adjust size
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
