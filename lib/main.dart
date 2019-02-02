import 'package:flutter/material.dart';
import 'package:flutter_news/news_app.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "N e w s   A p p",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
            ),
          ),
        ),
        body: NewsApp(),
      ),
    );
  }
}
