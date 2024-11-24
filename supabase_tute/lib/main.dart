import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tute/note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://epykmzthdvuvqthpuwzk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVweWttenRoZHZ1dnF0aHB1d3prIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEyMzgwNDcsImV4cCI6MjAzNjgxNDA0N30.vuPh4TRERl61Wgowt4jJbeYNuEDGf1lvmMeJk20Yads',
  );
  runApp(
    MyApp(),
  );
}

//project url: https://epykmzthdvuvqthpuwzk.supabase.co
//project API key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVweWttenRoZHZ1dnF0aHB1d3prIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEyMzgwNDcsImV4cCI6MjAzNjgxNDA0N30.vuPh4TRERl61Wgowt4jJbeYNuEDGf1lvmMeJk20Yads

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}
