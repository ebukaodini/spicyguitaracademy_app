import 'package:cached_video_player/cached_video_player.dart';
// import 'package:audioplayer/audioplayer.dart';
import 'dart:math';
import 'package:cache_audio_player/cache_audio_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

import '../../services/app.dart';

// // Audio
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:audioplayer/audioplayer.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage();

  @override
  TutorialPageState createState() => new TutorialPageState();
}

class TutorialPageState extends State<TutorialPage> {
  // video controller
  CachedVideoPlayerController _videoController;
  // AudioPlayer _audioController, _practiceController;
  final CacheAudioPlayer _practiceController = CacheAudioPlayer();
  StreamSubscription<AudioPlayerState> _practiceStateSubscription;
  StreamSubscription<double> _practiceBufferSubscription;
  StreamSubscription<double> _practiceTimeElapsedSubscription;
  StreamSubscription<Object> _practiceErrorSubscription;

  AudioPlayerState _practiceState = AudioPlayerState.PAUSED;
  double _practiceBufferedPercentage = 0;
  double _practiceTimeInSeconds = 0;
  double _practicePercentageOfTimeElapsed = 0;
  int _practiceTotalDuration = 0;
  Object _practiceError;
  bool _practiceIsSeekng = false;
  double _practiceValueToSeekTo = 0;

  // bool courseLocked = true;
  String _videoOrAudio = 'video';
  bool _audioIsPlaying = false;
  // bool _practiceIsPlaying = false;
  bool _showNote = false;

  String _practiceFormattedTime() {
    return Duration(seconds: _practiceTimeInSeconds.toInt()).toString();
  }

  _practiceUpdateSliderValue() {
    if (_practiceTotalDuration == 0) {
      _practiceController.lengthInseconds().then((totalDuration) {
        _practiceTotalDuration = totalDuration.toInt();
      }).catchError((error) {
        _practiceError = error;
      });
    } else {
      if (_practiceIsSeekng) {
        _practiceIsSeekng = false;
        final double value = _practiceValueToSeekTo;
        _practiceValueToSeekTo = 0;
        _practicePercentageOfTimeElapsed = value;
      } else {
        _practicePercentageOfTimeElapsed = min(_practiceTimeInSeconds / _practiceTotalDuration, 1.0);
      }
    }
  }

  Icon _practiceIcon() {
    switch (_practiceState) {
      case AudioPlayerState.PLAYING:
        return Icon(Icons.pause);
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
      case AudioPlayerState.FINISHED:
        return Icon(Icons.play_arrow);
      default:
        return Icon(Icons.error);
    }
  }

  _practiceOnPressed() {
    switch (_practiceState) {
      case AudioPlayerState.PLAYING:
        return _practiceController.stop();
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
        return _practiceController.play();
      case AudioPlayerState.FINISHED:
        _practicePercentageOfTimeElapsed = 0;
        _practiceTimeInSeconds = 0;
        return _practiceController.play();
      default:
        {}
    }
  }

  @override
  void initState() {
    super.initState();
    if (Tutorial.video != null) {
      _videoOrAudio = 'video';
      _videoController =
          CachedVideoPlayerController.network('${App.appurl}/${Tutorial.video}')
            ..initialize().then((_) {
              setState(() {});
            });
      // _videoController.setPlaybackSpeed = ;
      _videoController.setLooping(true);
      // _videoController.play();
    } else if (Tutorial.audio != null) {
      // _videoOrAudio = 'audio';
      // _audioController = AudioPlayer();
      // _audioController.play('${App.appurl}/${Tutorial.audio}');
      // // _audioPlayerStateSubscription =
      // _audioController.onPlayerStateChanged.listen((s) {
      //   if (s == AudioPlayerState.PLAYING) {
      //     setState(() => _audioIsPlaying = true);
      //     //_audioController.duration);
      //   } else {
      //     setState(() => _audioIsPlaying = false);
      //   }
      //   if (s == AudioPlayerState.STOPPED) {
      //     // onComplete();
      //     // setState(() {
      //     //   position = duration;
      //     // });
      //   }
      // }, onError: (msg) {
      //   setState(() {
      //     // playerState = PlayerState.stopped;
      //     // duration = new Duration(seconds: 0);
      //     // position = new Duration(seconds: 0);
      //   });
      // });
    }

    if (Tutorial.practice != null) {
      // _practiceController = AudioPlayer();
      // _practiceController.play('${App.appurl}/${Tutorial.practice}');
      // _practiceController.onPlayerStateChanged.listen((s) {
      //   if (s == AudioPlayerState.PLAYING) {
      //       setState(() => _audioIsPlaying = true);
      //       //_audioController.duration);
      //     } else {
      //       setState(() => _audioIsPlaying = false);
      //     }
      //     if (s == AudioPlayerState.STOPPED) {
      //       // onComplete();
      //       setState(() {
      //         _practicePosition = _practiceDuration;
      //       });
      //     }
      //   }, onError: (msg) {
      //     setState(() {
      //       playerState = PlayerState.stopped;
      //       _practiceDuration = new Duration(seconds: 0);
      //       _practicePosition = new Duration(seconds: 0);
      //     });
      //   }
      // );
      _practiceController.registerListeners();
      _practiceStateSubscription =
          _practiceController.onStateChanged.listen((AudioPlayerState state) {
        setState(() {
          _practiceState = state;
        });
      });
      _practiceBufferSubscription = _practiceController.onPlayerBuffered
          .listen((double percentageBuffered) {
        setState(() {
          _practiceBufferedPercentage = percentageBuffered;
        });
      });
      _practiceTimeElapsedSubscription =
          _practiceController.onTimeElapsed.listen((double timeInSeconds) {
        setState(() {
          _practiceTimeInSeconds = timeInSeconds;
        });
      });
      _practiceErrorSubscription =
          _practiceController.onError.listen((Object error) {
        setState(() {
          _practiceError = error;
        });
      });
      _practiceController.loadUrl(Tutorial.practice);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: OrientationBuilder(builder: (context, orientation) {
          return SafeArea(
              minimum: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  // course title and the number of lessons
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 17, right: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // back button
                        Container(
                          child: MaterialButton(
                            minWidth: 20,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Icon(
                              Icons.arrow_back_ios,
                              color: Color.fromRGBO(107, 43, 20, 1.0),
                              size: 20.0,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.white)),
                          ),
                        ),

                        // Tablature
                        Container(
                          child: MaterialButton(
                            color: Color.fromRGBO(107, 43, 20, 1.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            onPressed: () {
                              Navigator.pushNamed(context, '/tutorial_tab');
                            },
                            child: Text(
                              "Tablature",
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              // side: BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // the tutorial
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    padding: EdgeInsets.only(
                        bottom: 40, top: _videoOrAudio == 'video' ? 0.0 : 20.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 2.0)
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        // add the thumbnail for the lesson
                        _videoOrAudio == 'video'
                            ? _videoController.value.initialized
                                ? AspectRatio(
                                    aspectRatio:
                                        _videoController.value.aspectRatio,
                                    child: CachedVideoPlayer(_videoController),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width,
                                    height: 200.00,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: NetworkImage(
                                            '${App.appurl}/${Tutorial.thumbnail}'),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    child: null)
                            : Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context)
                                    .copyWith()
                                    .size
                                    .width,
                                height: 200.00,
                                decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                        center: Alignment.center,
                                        colors: [
                                      Color.fromRGBO(112, 112, 112, 0.8),
                                      Colors.white
                                    ])),
                                child: SvgPicture.asset(
                                    "assets/imgs/icons/big_mic.svg",
                                    color: Color.fromRGBO(107, 43, 20, 1.0),
                                    fit: BoxFit.scaleDown)),

                        // the play/pause controller
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 3.0),
                            padding: EdgeInsets.only(right: 15.0),
                            child: Row(
                              children: [
                                IconButton(
                                  iconSize: 25.0,
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  onPressed: () {
                                    setState(() {
                                      // _videoOrAudio == 'video'
                                      //     ? 
                                          _videoController.value.isPlaying
                                              ? _videoController.pause()
                                              : _videoController.play()
                                          // : 
                                      ;
                                      // _audioIsPlaying == true
                                      //   ? _audioController.pause()
                                      //   : _audioController.play('${App.appurl}/${Tutorial.audio}')
                                      // ;
                                    });
                                  },
                                  icon: Icon(
                                    _videoOrAudio == 'video'
                                        ? _videoController.value.isPlaying
                                            ? Icons.pause_circle_outline
                                            : Icons.play_circle_outline
                                        : _audioIsPlaying == true
                                            ? Icons.pause
                                            : Icons.mic_none,
                                  ),
                                ),
                                // :
                                //   Container()

                                Expanded(
                                  child: VideoProgressIndicator(
                                      _videoController,
                                      allowScrubbing: true,
                                      padding: EdgeInsets.only(top: 0.0),
                                      colors: VideoProgressColors(
                                        backgroundColor:
                                            Color.fromRGBO(112, 112, 112, 0.1),
                                        bufferedColor:
                                            Color.fromRGBO(112, 112, 112, 0.3),
                                        playedColor:
                                            Color.fromRGBO(107, 43, 20, 1.0),
                                      )),
                                )
                              ],
                            )),

                        // The text contents
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: orientation == Orientation.portrait
                                  ? 300
                                  : 650,
                              child: Text(
                                Tutorial.title ?? 'No title',
                                // textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3, bottom: 10),
                              child: Text(
                                Tutorial.tutor ?? 'No Tutor',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: orientation == Orientation.portrait
                                  ? 300
                                  : 650,
                              child: Text(
                                Tutorial.description ?? 'No description',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 1.0),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Tutorial.note != null
                                  ? FlatButton(
                                      onPressed: () => setState(
                                          () => _showNote = !_showNote),
                                      child: Text(
                                          _showNote == false
                                              ? 'Read more'
                                              : 'Read less',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  107, 43, 20, 1.0))))
                                  : Container(),
                              _videoOrAudio == 'video'
                                  ? Tutorial.audio != null
                                      ? IconButton(
                                          onPressed: () {
                                            setState(
                                                () => _videoOrAudio = 'audio');
                                          },
                                          icon: Icon(Icons.mic),
                                          color:
                                              Color.fromRGBO(107, 43, 20, 1.0),
                                        )
                                      : Container()
                                  : Tutorial.video != null
                                      ? IconButton(
                                          onPressed: () {
                                            setState(
                                                () => _videoOrAudio = 'video');
                                          },
                                          icon: Icon(Icons.play_circle_filled),
                                          color:
                                              Color.fromRGBO(107, 43, 20, 1.0),
                                        )
                                      : Container(),
                            ],
                          ),
                        ),

                        // show the note if open
                        _showNote == true
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  Tutorial.note,
                                  style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1.0),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : Container(),

                        Tutorial.practice != null
                        ? 
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Listen to Practice Audio",
                              style: TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 1.0),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          )
                        : 
                          Container()
                        ,

                        Tutorial.practice != null
                            ? 
                              // Row(children: [
                              //   IconButton(
                              //       onPressed: () {},
                              //       color: Color.fromRGBO(107, 43, 20, 1.0),
                              //       icon: Icon(Icons.play_circle_outline)),
                              //   // Expanded(
                              //   // child:
                              //   // )
                              // ])
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: _practiceIcon(),
                                          onPressed: () {
                                            _practiceOnPressed();
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Slider(
                                          onChangeEnd: (double value) {
                                            _practiceValueToSeekTo = value;
                                            _practiceIsSeekng = true;
                                            _practiceController.seek(value).catchError((Object error) {
                                              setState(() {
                                                _practiceIsSeekng = false;
                                                _practiceError = error;
                                              });
                                            });
                                          },
                                          onChanged: (value) {},
                                          value: _practicePercentageOfTimeElapsed,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Time: ${_practiceFormattedTime()}"),
                                        SizedBox(width: 20,),
                                        Text("Buffer: $_practiceBufferedPercentage"),
                                      ],
                                    ),
                                    _practiceError == null ? SizedBox() : Text("there was an error $_practiceError"),
                                  ],
                                )
                              )
                            : Container(),
                      ],
                    ),
                  ),

                  // the audio
                  // Container(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  //       MaterialButton(onPressed: _play(), child: Text("PLAY"),),

                  //       MaterialButton(onPressed: _pause(), child: Text("PAUSE"),),

                  //       MaterialButton(onPressed: _stop(), child: Text("STOP"),),
                  //     ]

                  //   )
                  // ),
                ],
              )));
        }));
  }
}
