import 'package:flutter/material.dart';

class SignInTile extends StatelessWidget {
  final String imagePath;
  const SignInTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
