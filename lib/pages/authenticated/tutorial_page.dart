import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:spicyguitaracademy/pages/authenticated/videoWidget.dart';
import 'package:spicyguitaracademy/pages/authenticated/audioWidget.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage();

  @override
  TutorialPageState createState() => new TutorialPageState();
}

enum Screen { video, audio, practice, tablature, none }

class TutorialPageState extends State<TutorialPage> {
  Screen _displayscreen = Screen.none;
  bool _showNote = false;
  bool _showComment = false;
  TextEditingController _comment = new TextEditingController();
  List<Widget> _commentWidgets = [];

  @override
  void initState() {
    super.initState();

    if (currentTutorial == null) {
      Navigator.pop(context);
    }

    if (currentTutorial.video != null) {
      _displayscreen = Screen.video;
    } else if (currentTutorial.audio != null) {
      _displayscreen = Screen.audio;
    } else if (currentTutorial.tablature != null) {
      _displayscreen = Screen.tablature;
    } else if (currentTutorial.practice != null) {
      _displayscreen = Screen.practice;
    }

    loadUserCommentsOnThisLesson();
  }

  _submitComment() async {
    try {
      loading(context);
      await Tutorial.submitComment(
          context, _comment.text, currentTutorial.id, currentTutorial.tutor);
      _comment.clear();
      Navigator.pop(context);
      await loadUserCommentsOnThisLesson();
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e));
    }
  }

  loadUserCommentsOnThisLesson() async {
    try {
      List<dynamic> comments = await Tutorial.getTutorialComments(context);

      List<Widget> commentsWidgets = [];
      comments.forEach((comment) {
        String name, avatar, date;
        // who;
        if (Student.email == comment['sender']) {
          name = '${Student.firstname} ${Student.lastname}';
          avatar = '${Student.avatar}';
          // who = 'me';
        } else {
          name = comment['tutor']['name'];
          avatar = comment['tutor']['avatar'];
          // who = 'tutor';
        }
        date = comment['date_added'];

        commentsWidgets.add(new Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(107, 43, 20, 0.2),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            // alignment: who == "me" ? Alignment.centerRight : Alignment.centerLeft,
            alignment: Alignment.topRight,
            width: screen(context).width, // * 0.8,
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 20,
                    backgroundColor: brown,
                    backgroundImage: NetworkImage('$baseUrl/$avatar', headers: {
                      'cache-control': 'max-age=0, must-revalidate'
                    })),
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
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: brown,
                                        fontWeight: FontWeight.bold)),
                                // Expanded(child:
                                Text("$date",
                                    maxLines: 1,
                                    style: TextStyle(color: brown)),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 1.0,
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
        _commentWidgets = commentsWidgets;
      });
    } catch (e) {
      error(context, stripExceptions(e));
    }
  }

  Widget renderDisplayScreen() {
    if (_displayscreen == Screen.video) {
      return Container(
          height: (screen(context).width * 2) / 3,
          width: screen(context).width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage(
                  Uri.parse('$baseUrl/${currentTutorial.thumbnail}').toString(),
                  headers: {'cache-control': 'max-age=0, must-revalidate'}),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: VideoWidget(
            play: true,
            url: "$baseUrl/${currentTutorial.video}",
          ));
    } else if (_displayscreen == Screen.audio) {
      return Container(
          height: (screen(context).width * 2) / 3,
          child: Column(children: [
            Expanded(
              child: Image.asset(
                "assets/imgs/icons/playing_audio.png",
                fit: BoxFit.fitWidth,
                matchTextDirection: true,
                excludeFromSemantics: true,
              ),
            ),
            AudioWidget(play: true, url: "$baseUrl/${currentTutorial.audio}")
          ]));
    } else if (_displayscreen == Screen.practice) {
      return Container(
          height: (screen(context).width * 2) / 3,
          child: Column(children: [
            Expanded(
              child: Image.asset(
                "assets/imgs/icons/playing_audio.png",
                fit: BoxFit.fitWidth,
                matchTextDirection: true,
                excludeFromSemantics: true,
              ),
            ),
            AudioWidget(play: true, url: "$baseUrl/${currentTutorial.practice}")
          ]));
    } else if (_displayscreen == Screen.tablature) {
      return Container(
          height: screen(context).height * 0.6,
          child: PDF.network("$baseUrl/${currentTutorial.tablature}"));
    }
    // No Audio/Video
    return Center(
        child: Icon(Icons.cancel_presentation_rounded, size: 200, color: grey));
  }

  void nextLesson() async {
    try {
      loading(context);
      // get the index of the current tutorial in the tutorial lessons list
      int currentIndex = tutorialLessons.indexOf(currentTutorial);

      // use the index to get the next lesson if this lesson is not the last
      if (currentTutorial != tutorialLessons.last) {
        setCurrentTutorial(tutorialLessons.elementAt(currentIndex + 1));
        if (Lessons.source == LessonSource.normal)
          await Lessons.activateLesson(context);
        else if (Lessons.source == LessonSource.featured)
          await Lessons.activateFeaturedLesson(context);
        // then route to the lesson
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/tutorial_page');
      }
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e));
    }
  }

  void previousLesson() async {
    try {
      loading(context);
      // get the index of the current tutorial in the tutorial lessons list
      int currentIndex = tutorialLessons.indexOf(currentTutorial);

      // use the index to get the previous lesson if this lesson is not the first
      if (currentTutorial != tutorialLessons.first) {
        setCurrentTutorial(tutorialLessons.elementAt(currentIndex - 1));

        if (Lessons.source == LessonSource.normal)
          await Lessons.activateLesson(context);
        else if (Lessons.source == LessonSource.featured)
          await Lessons.activateFeaturedLesson(context);
        // then route to the lesson
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/tutorial_page');
      }
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_displayscreen == Screen.tablature
                ? screen(context).height * 0.6
                : (screen(context).width * 2) / 3),
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
                        // the tutorial options
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: currentTutorial.video != null
                                  ? () => setState(
                                      () => _displayscreen = Screen.video)
                                  : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Video",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _displayscreen == Screen.video
                                            ? brown
                                            : currentTutorial.video != null
                                                ? darkgrey
                                                : Colors.grey[350]),
                                  ),
                                  _displayscreen == Screen.video
                                      ? Container(
                                          alignment: Alignment.topRight,
                                          height: 5,
                                          margin: EdgeInsets.only(top: 2),
                                          width: 45,
                                          color: brown,
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: currentTutorial.audio != null
                                  ? () => setState(
                                      () => _displayscreen = Screen.audio)
                                  : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Audio",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _displayscreen == Screen.audio
                                            ? brown
                                            : currentTutorial.audio != null
                                                ? darkgrey
                                                : Colors.grey[350]),
                                  ),
                                  _displayscreen == Screen.audio
                                      ? Container(
                                          alignment: Alignment.topRight,
                                          height: 5,
                                          margin: EdgeInsets.only(top: 2),
                                          width: 45,
                                          color: brown,
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: currentTutorial.practice != null
                                  ? () => setState(
                                      () => _displayscreen = Screen.practice)
                                  : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Practice Loop",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _displayscreen == Screen.practice
                                            ? brown
                                            : currentTutorial.practice != null
                                                ? darkgrey
                                                : Colors.grey[350]),
                                  ),
                                  _displayscreen == Screen.practice
                                      ? Container(
                                          alignment: Alignment.topRight,
                                          height: 5,
                                          margin: EdgeInsets.only(top: 2),
                                          width: 45,
                                          color: brown,
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: currentTutorial.tablature != null
                                  ? () => setState(
                                      () => _displayscreen = Screen.tablature)
                                  : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tablature",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _displayscreen ==
                                                Screen.tablature
                                            ? brown
                                            : currentTutorial.tablature != null
                                                ? darkgrey
                                                : Colors.grey[350]),
                                  ),
                                  _displayscreen == Screen.tablature
                                      ? Container(
                                          alignment: Alignment.topRight,
                                          height: 5,
                                          margin: EdgeInsets.only(top: 2),
                                          width: 45,
                                          color: brown,
                                        )
                                      : Container()
                                ],
                              ),
                            )
                          ],
                        ),

                        // The text contents
                        Text(
                          currentTutorial.title,
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
                          currentTutorial.tutor,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: darkgrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${currentTutorial.description}",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: darkgrey,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: 5),

                        // Read more indication
                        currentTutorial.note != null
                            ? TextButton(
                                onPressed: () =>
                                    setState(() => _showNote = !_showNote),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Notes',
                                        style: TextStyle(
                                            color: brown, fontSize: 16)),
                                    SizedBox(width: 2),
                                    Icon(
                                        _showNote
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: brown)
                                  ],
                                ))
                            : Container(),

                        // lesson Note
                        currentTutorial.note != null && _showNote == true
                            ? Text(
                                currentTutorial.note ?? "No notes",
                                style: TextStyle(
                                  color: darkgrey,
                                  fontSize: 15,
                                ),
                              )
                            : Container(),

                        // the previous/next
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Previous lesson
                            currentTutorial != tutorialLessons.first
                                ? MaterialButton(
                                    onPressed: () {
                                      previousLesson();
                                    },
                                    color: brown,
                                    textColor: Colors.white,
                                    child: Text('PREVIOUS',
                                        style: TextStyle(fontSize: 16)))
                                : Container(),

                            // Next lesson
                            currentTutorial != tutorialLessons.last
                                ? MaterialButton(
                                    onPressed: () {
                                      nextLesson();
                                    },
                                    color: brown,
                                    textColor: Colors.white,
                                    child: Text('NEXT',
                                        style: TextStyle(fontSize: 16)))
                                : Container()
                          ],
                        ),

                        TextButton(
                            onPressed: () =>
                                setState(() => _showComment = !_showComment),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Comments',
                                    style:
                                        TextStyle(color: brown, fontSize: 16)),
                                SizedBox(width: 2),
                                Icon(
                                    _showComment
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: brown)
                              ],
                            )),

                        _showComment == true
                            ? Column(
                                children: _commentWidgets,
                              )
                            : Container()
                      ],
                    )),
              ])),
            ),

            // comment section
            Container(
                // height: 50,
                padding: EdgeInsets.all(0),
                width: screen(context).width,
                // color: Colors.white,
                decoration: BoxDecoration(
                    color: grey,
                    border: Border(
                      bottom: BorderSide(width: 2.0, color: brown),
                      // width: 1.0, color: brown
                    )),
                child: TextField(
                    controller: _comment,
                    autocorrect: true,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      _submitComment();
                    },
                    style: TextStyle(fontSize: 20.0, color: brown),
                    decoration: InputDecoration(
                        hintText: "Write a comment",
                        suffix: IconButton(
                            onPressed: () {
                              _submitComment();
                            },
                            icon: Icon(
                              Icons.send,
                              color: brown,
                            ))))),
          ]),
        ));
  }
}
