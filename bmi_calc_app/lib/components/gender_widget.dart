import 'package:bmi_calc_app/constants.dart';
import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 60.0,
          color: Colors.white,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
