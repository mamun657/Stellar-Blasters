import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/ecocity.jpg", 
          height: 150, 
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
