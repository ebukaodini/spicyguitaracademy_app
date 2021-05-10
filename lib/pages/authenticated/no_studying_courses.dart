import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class NoStudyingCoursesPage extends StatefulWidget {
  NoStudyingCoursesPage();

  @override
  NotStyudyingCoursesPageState createState() =>
      new NotStyudyingCoursesPageState();
}

class NotStyudyingCoursesPageState extends State<NoStudyingCoursesPage> {
  NotStyudyingCoursesPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              "No Courses!",
              maxLines: 2,
              style: TextStyle(
                  fontSize: 25.0, color: brown, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              Student.subscription == false
                  ? "Choose a subscription plan"
                  : "Choose a category to learn from by tapping the button.",
              style: TextStyle(
                  fontSize: 20.0, color: darkgrey, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
            MaterialButton(
              minWidth: 15,
              color: brown,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              onPressed: () => setState(() {
                if (Student.subscription == false) {
                  Navigator.pushNamed(context, '/choose_plan');
                } else {
                  Navigator.pushNamed(context, '/choose_category');
                }
              }),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 25.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ]),
    )));
  }
}
