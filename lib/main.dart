import 'package:dot_box_game/game/about_screen.dart';

import 'package:flutter/material.dart';
import './game/game_screen.dart';

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
        routes: {
          "/about": (context) => const AboutScreen(),
        },
        home: Scaffold(
          body: DotsAndBoxesApp(),
        ));
  }
}
