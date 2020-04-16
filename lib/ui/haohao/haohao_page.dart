import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HaoHaoPage extends StatefulWidget {
  @override
  _HaoHaoPageState createState() => _HaoHaoPageState();
}

class _HaoHaoPageState extends State<HaoHaoPage> {
  final player = VideoPlayerController.asset('1.mp4');
  ChewieController chewieController;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: player,
      showControls: false,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
    chewieController.play();
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
