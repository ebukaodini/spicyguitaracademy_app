import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
// import 'package:spicyguitaracademy/models.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
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
  //         try {
  //           loading(context);
  //           await Lessons.getLessons(context, course.id);
  //           await Courses.getAssigment(context, course.id);
  //           Navigator.pop(context);
  //           Navigator.pushNamed(context, "/lessons_page", arguments: {
  //             'courseTitle': course.title,
  //             'courseActive': course.status,
  //             'courseId': course.id,
  //           });
  //         } catch (e) {
  //           Navigator.pop(context);
  //           error(context, stripExceptions(e));
  //         }
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
          'Settings',
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
