import 'package:flutter/material.dart';
import 'package:fun_animation/animation.dart';
import 'package:fun_animation/animations/falling_snow.dart';
import 'package:fun_animation/emojis/smiling.dart';

import 'emojis/cold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ColdEmoji(),
      debugShowCheckedModeBanner: false,
    );
  }
}

