import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratealert_app/providers/exchange_rate_provider.dart';
import 'package:ratealert_app/views/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExchangeRateProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RateAlert',
      home: HomeScreen(),
    );
  }
}
