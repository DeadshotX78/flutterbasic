import 'package:flutter/material.dart';
import 'package:noti_tute/noti_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotiService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NotiService().showNotification(
              title: 'Hello',
              body: 'This is a notification',
            );
          },
          child: const Text('Show Notification'),
        ),
      ),
    );
  }
}
