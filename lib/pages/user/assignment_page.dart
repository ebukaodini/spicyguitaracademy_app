// import 'package:flutter/foundation.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../../services/app.dart';

class AssignmentPage extends StatefulWidget {
  AssignmentPage();

  @override
  AssignmentPageState createState() => new AssignmentPageState();
}

class AssignmentPageState extends State<AssignmentPage> {
  // video controller
  CachedVideoPlayerController _videoController;

  TextEditingController _textController = TextEditingController();

  // bool courseLocked = true;
  bool _videoAssignment = false;
  // bool _showNote = false;

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
              image: AssetImage('assets/imgs/pictures/course_img_default.jpg'),
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

  double _videoPosition = 0;
  double _videoDuration = 0;
  String _formattedVideoPosition = "00:00";
  String _formattedVideoDuration = "00:00";
  File file;

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
        String name = '${User.firstname} ${User.lastname}';
        String avatar = '${User.avatar}';
        String date = comment['date_added'];

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

  @override
  void initState() {
    super.initState();

    // loadUserCommentsOnThisLesson();

    if (Assignment.questionVideo != "NULL") {
      _videoAssignment = true;
    }

    if (_videoAssignment == true) {
      _videoController = CachedVideoPlayerController.network(
          '${App.appurl}/${Assignment.questionVideo}')
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

    setState(() => _textController.value = TextEditingValue(text: Assignment.answerNote));
    
  }

  _submitNoteAnswer() async {
    loading(context, message: 'Submitting');
    Map<String, dynamic> resp =
        await request('POST', '/api/student/assignment/answer', body: {
      'note': _textController.text,
      'answerId': Assignment.answerId,
      'assignment': Assignment.id
    });
    Navigator.pop(context);
    if (resp['status'] == true) {
      success(context, resp['message']);
    } else {
      error(context, resp['message']);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoAssignment == true && _videoController.value.isPlaying) {
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
                    ],
                  ),
                ),

                // the tutorial
                Container(
                  margin:
                      EdgeInsets.only(top: 20, bottom: 5, left: 15, right: 15),
                  padding: EdgeInsets.only(
                      bottom: 40, top: _videoAssignment == true ? 0.0 : 20.0),
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
                      _videoAssignment == true ? _renderVideo() : Container(),

                      // the play/pause controller
                      _videoAssignment == true
                          ? Container(
                              child: Row(
                              children: [
                                IconButton(
                                  iconSize: 30.0,
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  onPressed: () {
                                    setState(() {
                                      // if (_videoAssignment == true) {
                                      _videoController.value.isPlaying
                                          ? _videoController.pause()
                                          : _videoController.play();
                                      // }
                                    });
                                  },
                                  icon: Icon(
                                    _videoAssignment == true &&
                                            _videoController.value.isPlaying
                                        ? Icons.pause_circle_outline
                                        : Icons.play_circle_outline,
                                  ),
                                ),
                                Expanded(
                                    child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                      Slider(
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
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(right: 22.0),
                                        child: Text(
                                            "$_formattedVideoPosition / $_formattedVideoDuration",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 0.2))),
                                      )
                                    ])),
                              ],
                            ))
                          : Container(),

                      SizedBox(
                        height: 20.0,
                      ),

                      // The text contents
                      Container(
                        width: MediaQuery.of(context).copyWith().size.width,
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Course Assignment',
                              // textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                              style: TextStyle(
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3, bottom: 10),
                              child: Text(
                                Assignment.tutor ?? 'No Tutor',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              Assignment.questionNote ?? 'No question note',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 1.0),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: Text('Answer Ratings',
                                  style: TextStyle(
                                      color: Color.fromRGBO(107, 43, 20, 1.0))),
                            ),
                            Container(
                                width: MediaQuery.of(context)
                                    .copyWith()
                                    .size
                                    .width,
                                child: Row(
                                  children: [
                                    Icon(
                                        int.parse(Assignment.answerRating) > 0
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0)),
                                    Icon(
                                        int.parse(Assignment.answerRating) > 1
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0)),
                                    Icon(
                                        int.parse(Assignment.answerRating) > 2
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0)),
                                    Icon(
                                        int.parse(Assignment.answerRating) > 3
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0)),
                                    Icon(
                                        int.parse(Assignment.answerRating) > 4
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0)),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      // Column(
                      //   children: _commentsWidget,
                      // ),

                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          width: MediaQuery.of(context).copyWith().size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .width,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  // color: Colors.white,
                                  child: TextField(
                                    controller: _textController,
                                    maxLines: 5,
                                    maxLength: 65535,
                                    maxLengthEnforced: true,
                                    cursorColor:
                                        Color.fromRGBO(112, 112, 112, 1.0),
                                    textInputAction: TextInputAction.send,
                                    onSubmitted: (String value) async {
                                      await _submitNoteAnswer();
                                    },
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(112, 112, 112, 1.0),
                                        fontSize: 18.0,
                                        height: 1.6),
                                    decoration: InputDecoration(
                                      hintText: "Write your answer",
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              112, 112, 112, 0.5)),
                                      fillColor: Colors.white,
                                      focusColor:
                                          Color.fromRGBO(107, 43, 20, 1.0),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0)
                                    ],
                                  )),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0))),
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 13),
                                onPressed: () async {
                                  // submit the answer
                                  await _submitNoteAnswer();
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Submit  ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                      Icon(Icons.send, color: Colors.white)
                                    ]),
                              ),
                              Center(
                                  child: Text('OR',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold))),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromRGBO(107, 43, 20, 1.0))),
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 13),
                                onPressed: () async {
                                  try {
                                    FilePickerResult result = await FilePicker
                                        .platform
                                        .pickFiles(type: FileType.video);
                                    if (result != null) {
                                      file = File(result.files.single.path);
                                    }
                                  } catch (e) {
                                    error(context,
                                        "Video picker error " + e.toString());
                                  }

                                  loading(context, message: 'Uploading');

                                  var resp = await upload(
                                      'POST',
                                      '/api/student/assignment/answer',
                                      'video',
                                      file,
                                      'video/mp4',
                                      body: {
                                        'answerId': Assignment.answerId,
                                        'assignment': Assignment.id
                                      });

                                  Navigator.pop(context);

                                  if (resp['status'] == true) {
                                    success(context, resp['message']);
                                  } else {
                                    error(context, resp['message']);
                                  }
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Upload Answer  ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                      Icon(
                                        Icons.attachment,
                                        color: Colors.white,
                                      )
                                    ]),
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
