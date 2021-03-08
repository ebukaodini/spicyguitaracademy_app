import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class VideoWidget extends StatefulWidget {
  final bool play;
  final String url;

  const VideoWidget({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new Container(
            child: Chewie(
              key: new PageStorageKey(widget.url),
              controller: ChewieController(
                videoPlayerController: videoPlayerController,
                aspectRatio: 3 / 2,
                // Prepare the video to be played and display the first frame
                autoInitialize: true,
                looping: false,
                autoPlay: false,
                allowFullScreen: true,
                allowMuting: true,
                showControls: true,
                playbackSpeeds: [0.25, 0.5, 0.75, 1, 1.25],
                deviceOrientationsOnEnterFullScreen: [
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ],
                deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
                cupertinoProgressColors: ChewieProgressColors(
                  playedColor: brown,
                  handleColor: brown,
                  backgroundColor: grey,
                  bufferedColor: darkgrey,
                ),
                materialProgressColors: ChewieProgressColors(
                  playedColor: brown,
                  handleColor: brown,
                  backgroundColor: grey,
                  bufferedColor: darkgrey,
                ),
                placeholder: Container(
                  color: Colors.black,
                ),
                // Errors can occur for example when trying to play a video
                // from a non-existent URL
                errorBuilder: (context, errorMessage) {
                  return Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            )
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                // Colors.white
                darkgrey
              ),
            ),
          );
        }
      },
    );
  }
}
