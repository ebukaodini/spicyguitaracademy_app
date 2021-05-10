import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpPage extends StatefulWidget {
  @override
  HelpPageState createState() => new HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  // properties
  List<Widget> _searchResult = [];

  @override
  void initState() {
    super.initState();
  }

  // void _searchCourses(value) {
  //   List<Widget> result = [];
  //   value = value.trim().toLowerCase();

  //   if (value.trim().isEmpty) return;

  //   studyingCourses.forEach((Course course) {
  //     var title = course.title.trim().toLowerCase();
  //     var description = course.description.trim().toLowerCase();

  //     print("q: " + course.title);
  //     if (title.contains(value) || description.contains(value)) {
  //       print("r: " + course.title);
  //       result.add(renderCourse(course, context, () async {
  //         loading(context);
  //         await Lessons.getLessons(context, course.id);
  //         await Courses.getAssigment(context, course.id);
  //         Navigator.pop(context);
  //         Navigator.pushNamed(context, "/lessons_page", arguments: {
  //           'courseTitle': course.title,
  //           'courseActive': course.status,
  //           'courseId': course.id,
  //         });
  //       }, showProgress: false));
  //     }
  //   });

  //   setState(() {
  //     if (result.isEmpty) {
  //       result.add(Container(child: Text("No result.")));
  //     }
  //     _searchResult = result;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: brown),
        backgroundColor: grey,
        centerTitle: true,
        title: Text(
          'Help',
          style: TextStyle(
              color: brown,
              fontSize: 30,
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Column(
          children: _searchResult,
        )
      ])),
    );
  }
}
