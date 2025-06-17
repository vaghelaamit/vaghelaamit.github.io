import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website_porfolio/PortfolioPage.dart';

void main() => runApp(MyPortfolioApp());

class MyPortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amit Vaghela',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 14, height: 1.6),
        ),
      ),
      home: PortfolioPage(),
    );
  }
}
