import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:spicyguitaracademy/common.dart';

class AudioWidget extends StatefulWidget {
  final bool play;
  final String url;

  const AudioWidget({Key key, @required this.url, @required this.play})
      : super(key: key);

  @override
  _AudioWidgetState createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);

    // videoPlayerController.

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
            child: ChewieAudio(
              key: new PageStorageKey(widget.url),
              controller: ChewieAudioController(
                videoPlayerController: videoPlayerController,
                // Prepare the video to be played and display the first frame
                autoInitialize: true,
                looping: false,
                autoPlay: false,
                allowMuting: true,
                showControls: true,
                allowPlaybackSpeedChanging: true,
                playbackSpeeds: [0.25, 0.5, 0.75, 1, 1.25],
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
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
