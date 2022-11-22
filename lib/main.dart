import 'package:flutter/material.dart';
import 'package:simple_dropdown_search/Presentation/Home/presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Simple Dropdown Search',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:  const HomeScreen(),
    );
  }
}

