
import 'package:flutter/material.dart';
import 'package:flutter_web/ui/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

