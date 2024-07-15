import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontSize: 50.0,
);

const kMessageTextStyle = TextStyle(
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kConditionTextStyle = TextStyle(
  fontSize: 50.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city_rounded,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide.none,
  ),
);
