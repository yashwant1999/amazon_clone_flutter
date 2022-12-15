import 'package:flutter/material.dart';

class CustomButoon extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButoon({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50)),
      child: Text(text),
    );
  }
}
