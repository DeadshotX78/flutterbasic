import 'package:boredom/models/activity.dart';
import 'package:boredom/services/bored_api_service.dart';
import 'package:boredom/widgets/activity_display.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Activity> activity;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchActivity();
  }

  void fetchActivity() {
    setState(() {
      activity = BoredApiService().fetchRandomActivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Boredom App'),
      ),
      body: FutureBuilder<Activity>(
          future: activity,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to load activity. Please retry.',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: fetchActivity,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return ActivityDisplay(activity: snapshot.data!.activity);
            } else {
              return Center(
                child: Text('No data found'),
              );
            }
          }),
    );
  }
}
