import 'dart:math';
import 'package:cache_audio_player/cache_audio_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../services/app.dart';

class TutorialPractice extends StatefulWidget {
  TutorialPractice();

  @override
  TutorialPracticeState createState() => new TutorialPracticeState();
}

class TutorialPracticeState extends State<TutorialPractice> {
  // cached audio controller
  final CacheAudioPlayer _practiceController = new CacheAudioPlayer();
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
  bool _practiceIsSeeking = false;
  double _practiceValueToSeekTo = 0;

  @override
  void initState() {
    super.initState();
    _practiceController.loadUrl('${App.appurl}/${currentTutorial.practice}');
    // cached audio player
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

    _practiceController.loadUrl('${App.appurl}/${currentTutorial.practice}');
  }

  @override
  void dispose() {
    super.dispose();
    _practiceStateSubscription.cancel();
    _practiceBufferSubscription.cancel();
    _practiceErrorSubscription.cancel();
    _practiceTimeElapsedSubscription.cancel();
    _practiceController.stop();
    _practiceController.unregisterListeners();
  }

  String _practiceFormattedTime() {
    int seconds;
    String paddedSeconds, paddedMinutes;
    String _practiceTime = "";

    Duration duration = Duration(seconds: _practiceTimeInSeconds.toInt());
    paddedMinutes = duration.inMinutes.toString().padLeft(2, '0');
    seconds = duration.inSeconds - (duration.inMinutes * 60);
    paddedSeconds = seconds.toString().padLeft(2, '0');
    _practiceTime = "$paddedMinutes:$paddedSeconds";

    duration = Duration(seconds: _practiceTotalDuration);
    seconds =
        duration.inSeconds > 60 ? duration.inSeconds % 60 : duration.inSeconds;
    paddedMinutes = duration.inMinutes.toString().padLeft(2, '0');
    paddedSeconds = seconds.toString().padLeft(2, '0');
    return "$_practiceTime / $paddedMinutes:$paddedSeconds";
  }

  _practiceUpdateSliderValue() {
    if (_practiceTotalDuration == 0) {
      _practiceController.lengthInseconds().then((totalDuration) {
        _practiceTotalDuration = totalDuration.toInt();
      }).catchError((error) {
        _practiceError = error;
      });
    } else {
      if (_practiceIsSeeking) {
        _practiceIsSeeking = false;
        final double value = _practiceValueToSeekTo;
        _practiceValueToSeekTo = 0;
        _practicePercentageOfTimeElapsed = value;
      } else {
        _practicePercentageOfTimeElapsed =
            min(_practiceTimeInSeconds / _practiceTotalDuration, 1.0);
      }
    }
  }

  Icon _practiceIcon() {
    switch (_practiceState) {
      case AudioPlayerState.PLAYING:
        return Icon(Icons.pause_circle_outline);
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
      case AudioPlayerState.FINISHED:
        return Icon(Icons.play_circle_outline);
      default:
        return Icon(Icons.error);
    }
  }

  _practiceOnPressed() {
    switch (_practiceState) {
      case AudioPlayerState.PLAYING:
        _practiceController.stop();
        break;
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
        _practiceController.play();
        break;
      case AudioPlayerState.FINISHED:
        _practicePercentageOfTimeElapsed = 0;
        _practiceTimeInSeconds = 0;
        _practiceController.play();
        break;
      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_practiceState == AudioPlayerState.PLAYING || _practiceIsSeeking) {
      _practiceUpdateSliderValue();
    }

    return new Scaffold(
        backgroundColor: Colors.white,
        body:
            // Center (
            //   child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    color: Color.fromRGBO(112, 112, 112, 1.0),
                    onPressed: () {
                      _practiceStateSubscription.cancel();
                      _practiceBufferSubscription.cancel();
                      _practiceErrorSubscription.cancel();
                      _practiceTimeElapsedSubscription.cancel();
                      _practiceController.stop();
                      _practiceController.unregisterListeners();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text("Practice Loop",
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0)),
                ],
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        iconSize: 25.0,
                        color: Color.fromRGBO(107, 43, 20, 1.0),
                        icon: _practiceIcon(),
                        onPressed: () {
                          _practiceOnPressed();
                        },
                      ),
                      Expanded(
                          child:
                              Stack(alignment: Alignment.bottomLeft, children: [
                        Slider(
                          onChangeEnd: (double value) {
                            _practiceValueToSeekTo = value;
                            _practiceIsSeeking = true;
                            _practiceController
                                .seek(value)
                                .catchError((Object error) {
                              setState(() {
                                _practiceIsSeeking = false;
                                _practiceError = error;
                              });
                            });
                          },
                          onChanged: (value) {
                            _practiceValueToSeekTo = value;
                            _practiceIsSeeking = true;
                            _practiceController
                                .seek(value)
                                .catchError((Object error) {
                              setState(() {
                                _practiceIsSeeking = false;
                                _practiceError = error;
                              });
                            });
                          },
                          inactiveColor: Color.fromRGBO(112, 112, 112, 0.1),
                          activeColor: Color.fromRGBO(107, 43, 20, 1.0),
                          value: _practicePercentageOfTimeElapsed,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 22.0),
                          child: Text("${_practiceFormattedTime()}",
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 0.2))),
                        )
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
            ])
        // )
        );
  }
}
