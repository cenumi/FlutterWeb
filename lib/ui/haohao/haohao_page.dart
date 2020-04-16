import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HaoHaoPage extends StatefulWidget {
  @override
  _HaoHaoPageState createState() => _HaoHaoPageState();
}

class _HaoHaoPageState extends State<HaoHaoPage> {
  final player = VideoPlayerController.network('https://d1.urlgot.top/files/1587002875645833242.mp4?n=黑人抬棺原版视频_.mp4&t=c356d4d4a7f1c2f11fb95598cd950da8');
  ChewieController chewieController;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: player,
      showControls: false,
      aspectRatio: 16/9,
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Chewie(controller: chewieController,),
          ),
          Container(
            child: Center(
              child: Text('浩浩哥哥我爱你', style: TextStyle(color: Colors.greenAccent,fontSize: 40)),
            ),
          ),
        ],
      ),
    );
  }
}
