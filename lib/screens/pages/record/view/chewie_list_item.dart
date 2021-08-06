import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget{
  final VideoPlayerController videoPlayerController;
  final looping;

  ChewieListItem({
    required this.videoPlayerController,
    this.looping,
    // required Key key
  });

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}


class _ChewieListItemState extends State<ChewieListItem> {
  late ChewieController _chewieController;

  @override
  void initState(){
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 16/9,
        autoInitialize: true,
        looping: widget.looping,

      errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,

      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }

}




