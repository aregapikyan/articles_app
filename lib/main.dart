import 'package:flutter/material.dart';
import 'package:flutter_app_articles/screens/screen_article_details.dart';
import 'package:flutter_app_articles/screens/screen_articles.dart';
import 'package:flutter_app_articles/screens/screen_tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabsScreen(),
    );
  }
}

