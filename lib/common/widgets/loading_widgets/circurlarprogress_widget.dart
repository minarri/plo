import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Color.fromARGB(255, 228, 225, 225),
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }
}
