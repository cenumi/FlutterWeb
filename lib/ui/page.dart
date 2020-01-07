import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web/ui/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';
import 'item.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<DateTime> _controller;
  StreamController<ColorConfig> _colorController;
  Timer _timer;
  Map config;

  @override
  void initState() {
    _colorController = StreamController();
    SharedPreferences.getInstance().then((sp) {
      final conf = sp.getString('config');
      if (conf != null) _colorController.add(ColorConfig.fromJson(jsonDecode(conf)));
    });
    _controller = StreamController();
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      _controller.add(DateTime.now());
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.close();
    _colorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ColorConfig>(
        initialData: ColorConfig(),
        stream: _colorController.stream,
        builder: (context, config) {
          return ColorConfigProvider(
            config.data,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                elevation: 0,
                actions: <Widget>[
                  Builder(
                      builder: (ctx) =>
                          IconButton(icon: Icon(Icons.settings), onPressed: () => _showDialog(ctx, config.data))),
                  IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () => showAboutDialog(context: context, children: [Text('进度！！！')]))
                ],
              ),
              backgroundColor: Color(config.data.backgroundColor),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text('进度', style: TextStyle(color: Color(config.data.textColor), fontSize: 35))),
                    StreamBuilder<DateTime>(
                        initialData: DateTime.now(),
                        stream: _controller.stream,
                        builder: (context, snapshot) {
                          return Wrap(
                            children: <Widget>[
                              Item(type: Type.year, dateTime: snapshot.data),
                              Item(type: Type.month, dateTime: snapshot.data),
                              Item(type: Type.week, dateTime: snapshot.data),
                              Item(type: Type.day, dateTime: snapshot.data),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showDialog(BuildContext ctx, ColorConfig config) async {
    final res = await showDialog(context: ctx, builder: (context) => SettingDialog(config: config));
    if (res != null) {
      _colorController.add(res);
    }
  }
}
