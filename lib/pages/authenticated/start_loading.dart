import 'package:flutter/material.dart';

import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class StartLoading extends StatefulWidget {
  @override
  StartLoadingState createState() => new StartLoadingState();
}

class StartLoadingState extends State<StartLoading> {
  @override
  void initState() {
    super.initState();
    _initializeCoursesAndLessons();
  }

  void _initializeCoursesAndLessons() async {
    try {
      // get all courses
      await Courses.getAllCourses(context);

      if (Student.subscription == true && Student.studyingCategory != 0) {
        // get the courses currently being studied
        await Courses.getStudyingCourses(context);
      } else {
        // get the courses studied by this student in the past
        // get the lessons studied by this student in the past
      }

      // get featured courses
      await Courses.getAllFeaturedCourses(context);

      // get my fewatured courses
      await Courses.getMyFeaturedCourses(context);

      // get free lessons
      await Lessons.getFreeLessons(context);

      Student.isLoaded = true;

      // route to dashboard
      Navigator.pushReplacementNamed(context, "/dashboard");
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/imgs/icons/loading_icon.gif"),
            Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Loading...",
                  style: TextStyle(color: brown, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
