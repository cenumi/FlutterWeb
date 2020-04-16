import 'package:flutter/material.dart';
import 'package:flutter_web/ui/haohao/haohao_page.dart';
import 'package:flutter_web/ui/progress/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (ctx) => MyHomePage(),
        '/haohao': (ctx) => HaoHaoPage(),
      },
    );
  }
}
