import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/home.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
