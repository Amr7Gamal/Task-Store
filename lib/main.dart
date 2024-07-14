import 'package:flutter/material.dart';
import 'package:task/base/myTheme.dart';
import 'package:task/ui/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: MyTheme.lightTheme,
      routes: {HomeScreen.nameKey : (_) => HomeScreen()},
      initialRoute: HomeScreen.nameKey,
    );
  }
}

