import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import '../../services/app.dart';

class StudyingCoursesLessons extends StatefulWidget {
  StudyingCoursesLessons();

  @override
  StudyingCoursesLessonsState createState() =>
      new StudyingCoursesLessonsState();
}

class Lessons {
  // the properties on the class
  String thumbnail,
      tutor,
      title,
      description,
      video,
      audio,
      tablature,
      practice,
      id,
      note;
  // the constructor
  Lessons(this.thumbnail, this.tutor, this.title, this.description, this.video,
      this.audio, this.tablature, this.practice, this.id, this.note);

  // constructing from json
  Lessons.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    tutor = json['tutor'];
    title = json['lesson'];
    description = json['description'];
    video = json['video'];
    audio = json['audio'];
    tablature = json['tablature'];
    practice = json['practice'];
    id = json['id'];
    note = json['note'];
  }
}

class StudyingCoursesLessonsState extends State<StudyingCoursesLessons> {
  // properties
  bool courseLocked = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _loadLessons(orientation, courseLessons) {
    List<Widget> vids = new List<Widget>();
    courseLessons.toList().forEach((lesson) {
      // print("this is the lesson: " + lesson);

      lesson = new Lessons(
          lesson['thumbnail'],
          lesson["tutor"],
          lesson["lesson"],
          lesson["description"],
          lesson['high_video'] ?? lesson['low_video'],
          lesson['audio'],
          lesson['tablature'],
          lesson['practice_audio'],
          lesson['id'],
          lesson['note']);

      vids.add(
        new CupertinoButton(
          onPressed: () {
            Tutorial.id = lesson.id;
            Tutorial.title = lesson.title;
            Tutorial.description = lesson.description;
            Tutorial.thumbnail = lesson.thumbnail;
            Tutorial.tutor = lesson.tutor;
            Tutorial.video = lesson.video;
            Tutorial.audio = lesson.audio;
            Tutorial.tablature = lesson.tablature;
            Tutorial.note = lesson.note;
            Tutorial.practice = lesson.practice;

            // if (courseLocked == false)
            Navigator.pushNamed(context, "/tutorial_page");
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            padding: EdgeInsets.only(bottom: 40),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0)
              ],
            ),
            child: Column(
              children: <Widget>[
                // add the thumbnail for the lesson
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).copyWith().size.width,
                  height: 200.00,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage('${App.appurl}/${lesson.thumbnail}'),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: courseLocked == true
                      ? SvgPicture.asset("assets/imgs/icons/lock_icon.svg",
                          color: Colors.white, fit: BoxFit.scaleDown)
                      : SvgPicture.asset(
                          "assets/imgs/icons/play_video_icon.svg",
                          color: Colors.white,
                          fit: BoxFit.scaleDown,
                        ),
                ),

                // The text contents
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: orientation == Orientation.portrait ? 300 : 650,
                      child: Text(
                        lesson.title,
                        // textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Color.fromRGBO(107, 43, 20, 1.0),
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, bottom: 10),
                      child: Text(
                        lesson.tutor,
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: orientation == Orientation.portrait ? 300 : 650,
                      child: Text(
                        lesson.description,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

    return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: vids);
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    String courseTitle = args['courseTitle'] ?? "No Title";
    num noLessons = args['noLessons'];
    List<dynamic> courseLessons = args['courseLessons'];

    return new Scaffold(
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: OrientationBuilder(builder: (context, orientation) {
          return SafeArea(
              minimum: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  // back button
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 20, left: 17, bottom: 30),
                    child: MaterialButton(
                      minWidth: 20,
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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

                  // course title and the number of lessons
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.all(Radius.circular(20)),
                      color: Color.fromRGBO(107, 43, 20, 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Number of Lessons
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(20)),
                            color: Color.fromRGBO(71, 29, 14, 1.0),
                          ),
                          child: Text(noLessons.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                        ),

                        // Lesson Title
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(courseTitle,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),

                  // the course list
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //   margin: EdgeInsets.only(top: 20, right: 15, left: 15),
                  //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                  //   // height: orientation == Orientation.portrait ? MediaQuery.of(context).copyWith().size.height : 600,
                  //   decoration: BoxDecoration(
                  //     borderRadius: new BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
                  //     color: Colors.white,
                  //   ),

                  // child:
                  _loadLessons(orientation, courseLessons),

                  // ),
                ],
              )));
        }));
  }
}
