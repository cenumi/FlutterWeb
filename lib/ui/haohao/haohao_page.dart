import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HaoHaoPage extends StatefulWidget {
  @override
  _HaoHaoPageState createState() => _HaoHaoPageState();
}

class _HaoHaoPageState extends State<HaoHaoPage> {
  final player = VideoPlayerController.network('https://d1.urlgot.top/files/1587003766814031023.mp4?n=黑人抬棺原版视频_.mp4&t=c356d4d4a7f1c2f11fb95598cd950da8');
  ChewieController chewieController;

  @override
  void initState() {
    chewieController = ChewieController(
      autoInitialize: true,
      videoPlayerController: player,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chewieController.play();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Chewie(
              controller: chewieController,
            ),
          ),
          AnimatedText(),
        ],
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  Timer timer;
  Color color = Colors.greenAccent;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if (color == Colors.greenAccent) {
          color = Colors.redAccent;
        } else {
          color = Colors.greenAccent;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text('浩浩哥哥我爱你', style: TextStyle(color: color, fontSize: 40)),
    ));
  }
}
