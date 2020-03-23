import 'package:flutter/material.dart';
import 'package:covid19_tracker/pages/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black
      ),
      home: DefaultTabController(
        length: 2,
        child: SplashScreen()
      ),
    );
  }
}
