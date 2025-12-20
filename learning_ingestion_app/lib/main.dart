import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LearningIngestionApp());
  print("APP Started");
}

class LearningIngestionApp extends StatelessWidget {
  const LearningIngestionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Ingestion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
