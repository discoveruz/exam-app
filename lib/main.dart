import 'package:examapp/models/scoreboard_model.dart';
import 'package:examapp/ui/fakescoreboard.dart';
import 'package:examapp/ui/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
