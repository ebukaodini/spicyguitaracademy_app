// import 'package:flutter/foundation.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'dart:math';
import 'package:cache_audio_player/cache_audio_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf_flutter/pdf_flutter.dart';

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:path_provider/path_provider.dart';

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

  TextEditingController _textController = TextEditingController();

  final CacheAudioPlayer _audioController = new CacheAudioPlayer();
  StreamSubscription<AudioPlayerState> _audioStateSubscription;
  StreamSubscription<double> _audioBufferSubscription;
  StreamSubscription<double> _audioTimeElapsedSubscription;
  StreamSubscription<Object> _audioErrorSubscription;

  AudioPlayerState _audioState = AudioPlayerState.PAUSED;
  double _audioBufferedPercentage = 0;
  double _audioTimeInSeconds = 0;
  double _audioPercentageOfTimeElapsed = 0;
  int _audioTotalDuration = 0;
  Object _audioError;
  bool _audioIsSeeking = false;
  double _audioValueToSeekTo = 0;

  // bool courseLocked = true;
  String _videoOrAudio = 'video';
  bool _showNote = false;

  String _audioFormattedTime() {
    int seconds;
    String paddedSeconds, paddedMinutes;
    String _audioTime = "";

    Duration duration = Duration(seconds: _audioTimeInSeconds.toInt());
    paddedMinutes = duration.inMinutes.toString().padLeft(2, '0');
    seconds = duration.inSeconds - (duration.inMinutes * 60);
    paddedSeconds = seconds.toString().padLeft(2, '0');
    _audioTime = "$paddedMinutes:$paddedSeconds";

    duration = Duration(seconds: _audioTotalDuration);
    seconds =
        duration.inSeconds > 60 ? duration.inSeconds % 60 : duration.inSeconds;
    paddedMinutes = duration.inMinutes.toString().padLeft(2, '0');
    paddedSeconds = seconds.toString().padLeft(2, '0');
    return "$_audioTime / $paddedMinutes:$paddedSeconds";
  }

  _audioUpdateSliderValue() {
    if (_audioTotalDuration == 0) {
      _audioController.lengthInseconds().then((totalDuration) {
        _audioTotalDuration = totalDuration.toInt();
      }).catchError((error) {
        _audioError = error;
      });
    } else {
      if (_audioIsSeeking) {
        _audioIsSeeking = false;
        final double value = _audioValueToSeekTo;
        _audioValueToSeekTo = 0;
        _audioPercentageOfTimeElapsed = value;
      } else {
        _audioPercentageOfTimeElapsed =
            min(_audioTimeInSeconds / _audioTotalDuration, 1.0);
      }
    }
  }

  IconData _audioIcon() {
    switch (_audioState) {
      case AudioPlayerState.PLAYING:
        return Icons.pause;
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
      case AudioPlayerState.FINISHED:
        return Icons.mic_none;
      default:
        return Icons.error;
    }
  }

  Duration _videoSeekToPosition(double moment) {
    Duration newPosition = Duration(seconds: moment.toInt());
    _videoPosition = newPosition.inSeconds.toDouble();
    return newPosition;
  }

  _videoUpdateSliderValue() {
    _videoPosition = _videoController.value.position.inSeconds.toDouble();
  }

  _videoUpdateTimeElapsed() {
    int seconds;
    String paddedSeconds, paddedMinutes;

    Duration duration = Duration(seconds: _videoPosition.toInt());
    paddedMinutes = duration.inMinutes.toString().padLeft(2, '0');
    seconds = duration.inSeconds - (duration.inMinutes * 60);
    paddedSeconds = seconds.toString().padLeft(2, '0');
    _formattedVideoPosition = "$paddedMinutes:$paddedSeconds";

    duration = Duration(seconds: _videoDuration.toInt());
    seconds =
        duration.inSeconds > 60 ? duration.inSeconds % 60 : duration.inSeconds;
    paddedMinutes = duration.inMinutes.toString().padLeft(2, '0');
    paddedSeconds = seconds.toString().padLeft(2, '0');
    _formattedVideoDuration = "$paddedMinutes:$paddedSeconds";
  }

  _renderVideo() {
    if (!_videoController.value.initialized) {
      return Container(
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).copyWith().size.width,
          height: 200.00,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage('${App.appurl}/${currentTutorial.thumbnail}'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: Color.fromRGBO(112, 112, 112, 0.1),
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(107, 43, 20, 1.0)),
          )));
    } else {
      return Stack(alignment: AlignmentDirectional.topEnd, children: [
        AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: CachedVideoPlayer(_videoController),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            child: IconButton(
                iconSize: 25.0,
                color: Colors.white,
                onPressed: () {},
                icon: SvgPicture.asset("assets/imgs/icons/maximize_icon.svg",
                    color: Colors.white, fit: BoxFit.scaleDown))),
      ]);
    }
  }

  _renderAudio() {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).copyWith().size.width,
        height: 200.00,
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: Alignment.center,
                colors: [Color.fromRGBO(112, 112, 112, 0.8), Colors.white])),
        child: SvgPicture.asset("assets/imgs/icons/big_mic.svg",
            color: Color.fromRGBO(107, 43, 20, 1.0), fit: BoxFit.scaleDown));
  }

  double _videoPosition = 0;
  double _videoDuration = 0;
  String _formattedVideoPosition = "00:00";
  String _formattedVideoDuration = "00:00";

  Widget renderComment(avatar, name, date, comment) {
    return new Container(
        decoration: new BoxDecoration(
          color: Color.fromRGBO(107, 43, 20, 0.2),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 20,
                backgroundColor: Color.fromRGBO(107, 43, 20, 1.0),
                backgroundImage: NetworkImage('${App.appurl}/$avatar')),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$name",
                                style: TextStyle(
                                    color: Color.fromRGBO(107, 43, 20, 1.0),
                                    fontWeight: FontWeight.bold)),
                            Text("$date",
                                style: TextStyle(
                                    color: Color.fromRGBO(107, 43, 20, 1.0))),
                          ],
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "$comment",
                          textAlign: TextAlign.start,
                        )
                      ],
                    ))),
          ],
        ));
  }

  List<Widget> _commentsWidget = [Container()];

  loadUserCommentsOnThisLesson() async {
    Map<String, dynamic> resp =
        await request('GET', "/api/lesson/${currentTutorial.id}/comments");

    if (resp['status'] == true) {
      List<dynamic> comments = resp['data'];

      List<Widget> commentsWidgets = new List<Widget>();

      comments.forEach((comment) {
        String name, avatar, date;
        if (User.email == comment['sender']) {
          name = '${User.firstname} ${User.lastname}';
          avatar = '${User.avatar}';
        } else {
          name = comment['tutor']['name'];
          avatar = comment['tutor']['avatar'];
        }
        date = comment['date_added'];

        commentsWidgets.add(new Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(107, 43, 20, 0.2),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(107, 43, 20, 1.0),
                    backgroundImage: NetworkImage('${App.appurl}/$avatar')),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$name",
                                    style: TextStyle(
                                        color: Color.fromRGBO(107, 43, 20, 1.0),
                                        fontWeight: FontWeight.bold)),
                                Text("$date",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0))),
                              ],
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "${comment['comment']}",
                              textAlign: TextAlign.start,
                            )
                          ],
                        ))),
              ],
            )));
      });

      setState(() {
        _commentsWidget = commentsWidgets;
      });
    }
  }

  takeThisLesson() async {
    await request('POST', "/api/student/takelesson",
        body: {'lesson': currentTutorial.id});

    // update the lessons taken
    var resp = await request('GET', studyingCourses);
    if (resp == false)
      Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (route) => false);
    // List<dynamic> json = resp['courses'];
    Courses.studyingCourses = resp['data'];
  }

  @override
  void initState() {
    super.initState();

    takeThisLesson();

    loadUserCommentsOnThisLesson();

    if (currentTutorial.video != null) {
      _videoOrAudio = 'video';
    } else {
      if (currentTutorial.audio != null) {
        _videoOrAudio = 'audio';
      }
    }

    if (currentTutorial.video != null) {
      _videoController = CachedVideoPlayerController.network(
          '${App.appurl}/${currentTutorial.video}')
        ..initialize().then((_) {
          setState(() {
            _videoDuration =
                _videoController.value.duration.inSeconds.toDouble();
            _videoPosition =
                _videoController.value.position.inSeconds.toDouble();

            _videoUpdateTimeElapsed();
          });
        });

      _videoController.setLooping(true);
      _videoController.addListener(() {
        setState(() {
          _videoDuration = _videoController.value.duration.inSeconds.toDouble();
          _videoPosition = _videoController.value.position.inSeconds.toDouble();
          _videoUpdateTimeElapsed();
        });
      });
    }

    if (currentTutorial.audio != null) {
      _audioController.loadUrl('${App.appurl}/${currentTutorial.audio}');
      // cached audio player
      _audioController.registerListeners();
      _audioStateSubscription =
          _audioController.onStateChanged.listen((AudioPlayerState state) {
        setState(() {
          _audioState = state;
        });
      });
      _audioBufferSubscription =
          _audioController.onPlayerBuffered.listen((double percentageBuffered) {
        setState(() {
          _audioBufferedPercentage = percentageBuffered;
        });
      });
      _audioTimeElapsedSubscription =
          _audioController.onTimeElapsed.listen((double timeInSeconds) {
        setState(() {
          _audioTimeInSeconds = timeInSeconds;
        });
      });
      _audioErrorSubscription = _audioController.onError.listen((Object error) {
        setState(() {
          _audioError = error;
        });
      });
    }
  }

  _submitComment() async {
    loading(context);
    Map<String, dynamic> resp =
        await request('POST', "/api/commentlesson", body: {
      'comment': _textController.text,
      'lessonId': currentTutorial.id,
      'receiver': currentTutorial.tutor
    });
    Navigator.pop(context);
    if (resp['status'] == true) {
      _textController.clear();
      // GET the comments for this user on this lesson
      loadUserCommentsOnThisLesson();
    }
  }

  _audioOnPressed() {
    switch (_audioState) {
      case AudioPlayerState.PLAYING:
        _audioController.stop();
        break;
      case AudioPlayerState.READYTOPLAY:
      case AudioPlayerState.BUFFERING:
      case AudioPlayerState.PAUSED:
        _audioController.play();
        break;
      case AudioPlayerState.FINISHED:
        _audioPercentageOfTimeElapsed = 0;
        _audioTimeInSeconds = 0;
        _audioController.play();
        break;
      default:
        {}
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();

    _audioStateSubscription.cancel();
    _audioBufferSubscription.cancel();
    _audioErrorSubscription.cancel();
    _audioTimeElapsedSubscription.cancel();
    _audioController.stop();
    _audioController.unregisterListeners();
  }

  @override
  Widget build(BuildContext context) {
    if (_audioState == AudioPlayerState.PLAYING || _audioIsSeeking) {
      _audioUpdateSliderValue();
    }

    if (_videoController.value.isPlaying) {
      _videoUpdateSliderValue();
    }

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
                      currentTutorial.tablature != null
                          ? Container(
                              child: MaterialButton(
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 18),
                                onPressed: () {
                                  // Navigator.pushNamed(context, '/tutorial_tab');
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
                            )
                          : Container(),
                    ],
                  ),
                ),

                // the tutorial
                Container(
                  margin:
                      EdgeInsets.only(top: 20, bottom: 5, left: 15, right: 15),
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
                          ? _renderVideo()
                          : _renderAudio(),

                      // the play/pause controller
                      Container(
                          child: Row(
                        children: [
                          IconButton(
                            iconSize: 30.0,
                            color: Color.fromRGBO(107, 43, 20, 1.0),
                            onPressed: () {
                              setState(() {
                                if (_videoOrAudio == 'video') {
                                  _videoController.value.isPlaying
                                      ? _videoController.pause()
                                      : _videoController.play();
                                }
                                if (_videoOrAudio == 'audio') {
                                  _audioOnPressed();
                                }
                              });
                            },
                            icon: Icon(
                              _videoOrAudio == 'video'
                                  ? _videoController.value.isPlaying
                                      ? Icons.pause_circle_outline
                                      : Icons.play_circle_outline
                                  : _audioIcon(),
                            ),
                          ),
                          Expanded(
                              child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                _videoOrAudio == 'video'
                                    ? Slider(
                                        onChangeEnd: (double value) {
                                          _videoController.seekTo(
                                              _videoSeekToPosition(value));
                                        },
                                        inactiveColor:
                                            Color.fromRGBO(112, 112, 112, 0.1),
                                        activeColor:
                                            Color.fromRGBO(107, 43, 20, 1.0),
                                        onChanged: (value) {
                                          _videoController.seekTo(
                                              _videoSeekToPosition(value));
                                        },
                                        max: _videoDuration,
                                        value: _videoPosition,
                                      )
                                    : Slider(
                                        onChangeEnd: (double value) {
                                          _audioValueToSeekTo = value;
                                          _audioIsSeeking = true;
                                          _audioController
                                              .seek(value)
                                              .catchError((Object error) {
                                            setState(() {
                                              _audioIsSeeking = false;
                                              _audioError = error;
                                            });
                                          });
                                          _audioController.play();
                                        },
                                        onChanged: (value) {
                                          _audioValueToSeekTo = value;
                                          _audioIsSeeking = true;
                                          _audioController
                                              .seek(value)
                                              .catchError((Object error) {
                                            setState(() {
                                              _audioIsSeeking = false;
                                              _audioError = error;
                                            });
                                          });
                                          _audioController.play();
                                        },
                                        inactiveColor:
                                            Color.fromRGBO(112, 112, 112, 0.1),
                                        activeColor:
                                            Color.fromRGBO(107, 43, 20, 1.0),
                                        // max: _audioTotalDuration.toDouble(),
                                        value: _audioPercentageOfTimeElapsed,
                                      ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 22.0),
                                  child: Text(
                                      _videoOrAudio == 'video'
                                          ? "$_formattedVideoPosition / $_formattedVideoDuration"
                                          : _audioFormattedTime(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              112, 112, 112, 0.2))),
                                )
                              ])),
                        ],
                      )),

                      SizedBox(
                        height: 20.0,
                      ),

                      // The text contents
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width:
                                orientation == Orientation.portrait ? 300 : 650,
                            child: Text(
                              currentTutorial.title ?? 'No title',
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
                              currentTutorial.tutor ?? 'No Tutor',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width:
                                orientation == Orientation.portrait ? 300 : 650,
                            child: Text(
                              currentTutorial.description ?? 'No description',
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
                            currentTutorial.note != null
                                ? FlatButton(
                                    onPressed: () =>
                                        setState(() => _showNote = !_showNote),
                                    child: Text(
                                        _showNote == false
                                            ? 'Read more'
                                            : 'Read less',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                107, 43, 20, 1.0))))
                                : Container(),
                            _videoOrAudio == 'video'
                                ? currentTutorial.audio != null
                                    ? IconButton(
                                        onPressed: () {
                                          setState(
                                              () => _videoOrAudio = 'audio');
                                        },
                                        icon: Icon(Icons.mic),
                                        color: Color.fromRGBO(107, 43, 20, 1.0),
                                      )
                                    : Container()
                                : currentTutorial.video != null
                                    ? IconButton(
                                        onPressed: () {
                                          setState(
                                              () => _videoOrAudio = 'video');
                                        },
                                        icon: Icon(Icons.play_circle_filled),
                                        color: Color.fromRGBO(107, 43, 20, 1.0),
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
                                currentTutorial.note,
                                style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 1.0),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : Container(),

                      currentTutorial.practice != null
                          ? Container(
                              margin: EdgeInsets.only(top: 10.0),
                              alignment: Alignment.centerLeft,
                              child: FlatButton(
                                  textColor: Color.fromRGBO(112, 112, 112, 1.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.mic),
                                      Text(
                                        "Practice Loop",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    if (currentTutorial.audio != null) {
                                      _audioStateSubscription.cancel();
                                      _audioBufferSubscription.cancel();
                                      _audioErrorSubscription.cancel();
                                      _audioTimeElapsedSubscription.cancel();
                                      _audioController.stop();
                                      _audioController.unregisterListeners();
                                    }
                                    Navigator.pushNamed(
                                        context, '/tutorial_practice');
                                  }))
                          : Container(),

                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              currentTutorial != tutorialLessons.first
                                  ? FlatButton(
                                      textColor:
                                          Color.fromRGBO(107, 43, 20, 1.0),
                                      onPressed: () {
                                        int currentIndex = tutorialLessons
                                            .indexOf(currentTutorial);

                                        if (currentTutorial !=
                                            tutorialLessons.first) {
                                          currentTutorial = tutorialLessons
                                              .elementAt(currentIndex - 1);
                                          Navigator.pushReplacementNamed(
                                              context, '/tutorial_page');
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_back),
                                          Text('Previous Lesson')
                                        ],
                                      ),
                                    )
                                  : Container(),
                              currentTutorial != tutorialLessons.last
                                  ? FlatButton(
                                      textColor:
                                          Color.fromRGBO(107, 43, 20, 1.0),
                                      onPressed: () {
                                        int currentIndex = tutorialLessons
                                            .indexOf(currentTutorial);

                                        if (currentTutorial !=
                                            tutorialLessons.last) {
                                          currentTutorial = tutorialLessons
                                              .elementAt(currentIndex + 1);
                                          Navigator.pushReplacementNamed(
                                              context, '/tutorial_page');
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Text('Next Lesson'),
                                          Icon(Icons.arrow_forward)
                                        ],
                                      ),
                                    )
                                  : Container()
                            ],
                          )),

                      Column(
                        children: _commentsWidget,
                      ),

                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width -
                                      130,
                                  // color: Colors.white,
                                  child: TextField(
                                    controller: _textController,
                                    // maxLength: 250,
                                    maxLengthEnforced: true,
                                    cursorColor:
                                        Color.fromRGBO(112, 112, 112, 1.0),
                                    textInputAction: TextInputAction.send,
                                    onSubmitted: (String value) async {
                                      await _submitComment();
                                    },
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(112, 112, 112, 1.0),
                                        fontSize: 18.0,
                                        height: 1.6),
                                    decoration: InputDecoration(
                                      hintText: "Write a comment",
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              112, 112, 112, 0.5)),
                                      fillColor: Colors.white,
                                      focusColor:
                                          Color.fromRGBO(107, 43, 20, 1.0),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0)
                                    ],
                                  )),
                              Container(
                                child: MaterialButton(
                                  minWidth: 20,
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13),
                                  onPressed: () async {
                                    // submit the comment/question
                                    await _submitComment();
                                  },
                                  child: new Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Color.fromRGBO(
                                              107, 43, 20, 1.0))),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            )));
      }),
    );
  }
}
