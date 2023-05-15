import 'package:bookish_front/camera/camera.dart';
import 'package:bookish_front/screen/HistoryScreen.dart';
import 'package:bookish_front/screen/HomeScreen.dart';
import 'package:bookish_front/screen/InputScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bookish',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/input': (context) => const InputScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}