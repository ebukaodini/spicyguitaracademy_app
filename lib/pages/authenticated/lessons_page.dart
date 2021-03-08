import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class LessonsPage extends StatefulWidget {
  @override
  LessonsPageState createState() => new LessonsPageState();
}

class LessonsPageState extends State<LessonsPage> {
  // properties
  bool courseLocked = false;

  @override
  void initState() {
    super.initState();
  }

  Widget assignmentWidget = Container();
  var courseId = 0;

  List<Widget> _loadLessons() {
    // tutorial lessons
    tutorialLessons = courseLessons;
    List<Widget> vids = new List<Widget>();
    courseLessons.forEach((lesson) {
      vids.add(renderLesson(lesson, context, () async {
        currentTutorial = lesson;
        if (Lessons.source == LessonSource.normal)
          await Lessons.activateLesson(context);
        else if (Lessons.source == LessonSource.featured)
          await Lessons.activateFeaturedLesson(context);
        Navigator.pushNamed(context, "/tutorial_page");
      }, courseLocked: courseLocked));
    });

    // add asignment
    if (Assignment.status == true) {
      vids.add(renderAssignment(context));
    }

    return vids;
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    String courseTitle = args['courseTitle'] ?? "No Title";
    courseLocked = !args['courseActive'];
    courseId = args['courseId'];
    // var assignmentResp = args['assignmentResp'];

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            title: Row(children: [
              Expanded(
                child: Text("$courseTitle",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  color: darkbrown,
                  child: Text("${courseLessons.length}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white)))
            ])),
        body: SingleChildScrollView(child: Column(children: _loadLessons())));
  }
}
