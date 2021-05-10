import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:spicyguitaracademy/pages/authenticated/videoWidget.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class AssignmentPage extends StatefulWidget {
  AssignmentPage();

  @override
  AssignmentPageState createState() => new AssignmentPageState();
}

enum Screen { video, none }

class AssignmentPageState extends State<AssignmentPage> {
  Screen _displayscreen = Screen.none;
  bool shouldUpload = true;
  File file;
  TextEditingController _answer = new TextEditingController();

  @override
  void initState() {
    super.initState();

    print(Assignment.questionVideo);

    if (Assignment == null) {
      Navigator.pop(context);
    }
    if (Assignment.questionVideo != null &&
        Assignment.questionVideo.isNotEmpty) {
      _displayscreen = Screen.video;
    }
  }

  _uploadAnswer() async {
    try {
      FilePickerResult result =
          await FilePicker.platform.pickFiles(type: FileType.video);
      if (result != null) {
        file = File(result.files.single.path);
      }
    } catch (e) {
      error(context, "Video picker error " + e.toString());
    }

    loading(context, message: 'Uploading');

    var resp = await upload('/api/student/assignment/answer', 'video', file,
        method: 'POST',
        headers: {
          'JWToken': Auth.token,
          'cache-control': 'max-age=0, must-revalidate'
        },
        body: {
          'answerId': "${Assignment.answerId}",
          'assignment': "${Assignment.id}"
        });

    Navigator.pop(context);

    if (resp['status'] == true) {
      setState(() => Assignment.answerVideo = resp['data']['path']);
    }
  }

  _submitAnswer() async {
    try {
      loading(context, message: 'Submitting');
      await Assignment.submitAnswer(context, _answer.text);
      setState(() => Assignment.answerNote = _answer.text);
      _answer.clear();
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e));
    }
  }

  Widget renderDisplayScreen() {
    if (_displayscreen == Screen.video) {
      return Container(
          height: (screen(context).width * 2) / 3,
          width: screen(context).width,
          child: VideoWidget(
            play: true,
            url: "$baseUrl/${Assignment.questionVideo}",
          ));
    }
    // No Audio/Video
    return Center(
        child: Icon(Icons.cancel_presentation_rounded, size: 200, color: grey));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight((screen(context).width * 2) / 3),
            child: renderDisplayScreen(),
          ),
          body: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Container(
                    width: screen(context).width,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // The text contents
                        Text(
                          "Course Assignment",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: TextStyle(
                            color: brown,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          Assignment.tutor,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: darkgrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${Assignment.questionNote}",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: darkgrey,
                            fontSize: 15.0,
                          ),
                        ),

                        SizedBox(height: 20),

                        Text(
                          "Review & Rating",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: TextStyle(
                            color: brown,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                                Assignment.answerRating > 0
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: brown),
                            Icon(
                                Assignment.answerRating > 1
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: brown),
                            Icon(
                                Assignment.answerRating > 2
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: brown),
                            Icon(
                                Assignment.answerRating > 3
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: brown),
                            Icon(
                                Assignment.answerRating > 4
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: brown),
                          ],
                        ),
                        SizedBox(height: 2),
                        Assignment.answerReview != null
                            ? Text(
                                "${Assignment.answerReview}",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: darkgrey,
                                  // fontSize: 15.0,
                                ),
                              )
                            : Container(),

                        SizedBox(height: 20),
                        Text(
                          "Your Answer",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: TextStyle(
                            color: brown,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Assignment.answerVideo != null &&
                                Assignment.answerVideo.isNotEmpty
                            ? Container(
                                height: (screen(context).width * 2) / 3,
                                width: screen(context).width,
                                child: VideoWidget(
                                  play: true,
                                  url: "$baseUrl/${Assignment.answerVideo}",
                                ))
                            : Container(),
                        SizedBox(height: 10),
                        Assignment.answerNote != null
                            ? Text(
                                "${Assignment.answerNote}",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: darkgrey,
                                  // fontSize: 15,
                                ),
                              )
                            : Container(),

                        SizedBox(height: 50)
                      ],
                    )),
              ])),
            ),

            // answer section
            Assignment.answerRating < 3
                ? Container(
                    padding: EdgeInsets.all(0),
                    width: screen(context).width,
                    decoration: BoxDecoration(
                        color: grey,
                        border: Border(
                          bottom: BorderSide(width: 2.0, color: brown),
                        )),
                    child: TextField(
                        controller: _answer,
                        autocorrect: true,
                        textInputAction: TextInputAction.send,
                        onChanged: (value) {
                          if (value.trim().isEmpty)
                            setState(() => shouldUpload = true);
                          else
                            setState(() => shouldUpload = false);
                        },
                        onSubmitted: (value) {
                          _submitAnswer();
                        },
                        style: TextStyle(fontSize: 20.0, color: brown),
                        decoration: InputDecoration(
                          hintText: "submit your answer",
                          suffix: shouldUpload == true
                              ? IconButton(
                                  // upload answer
                                  onPressed: () {
                                    _uploadAnswer();
                                  },
                                  icon: Icon(
                                    Icons.attachment,
                                    color: brown,
                                  ))
                              : IconButton(
                                  // send
                                  onPressed: () {
                                    _submitAnswer();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: brown,
                                  )),
                        )))
                : Container(),
          ]),
        ));
  }
}
