import 'package:flutter/material.dart';

class ActivityDisplay extends StatelessWidget {
  final String activity;
  const ActivityDisplay({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        activity,
        textAlign: TextAlign.center,
      ),
    );
  }
}
