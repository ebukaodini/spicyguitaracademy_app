import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';
// import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  // properties
  // all these variables should be abstracted in a class and used globally
  bool _notificationsExist = false;

  @override
  void initState() {
    super.initState();
    // _notJustLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // welcome & search
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi, ${Student.firstname}",
                          style: TextStyle(
                              color: brown,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900)),
                      Text("Welcome"),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: brown),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pushNamed(context, '/search_page');
                    },
                  )
                ],
              ),
              SizedBox(height: 20),

              // current category thumbnail
              Container(
                width: screen(context).width,
                height: 120,
                decoration: new BoxDecoration(
                  border: Border.all(
                      color: darkgrey, width: 1.0, style: BorderStyle.solid),
                  image: new DecorationImage(
                    image: ExactAssetImage(getStudentCategoryThumbnail()),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),

              // current category details
              Student.studyingCategory == 0
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/choose_category');
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Choose a Category",
                                  style: TextStyle(color: brown)),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(Icons.arrow_forward, color: brown),
                            ],
                          )))
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(Icons.bookmark, color: Color(0xFFDAA520)),
                            SizedBox(width: 10),
                            Text("${Student.studyingCategoryLabel}")
                          ]),
                          Text(
                              "${((Student.takenLessons / Student.allLessons) * 100).floor()}% Completed"),
                        ],
                      )),

              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, color: brown),
                  SizedBox(width: 10),
                  Text("Subscription Plan",
                      style:
                          TextStyle(color: brown, fontWeight: FontWeight.bold))
                ],
              ),
              // subscription plan
              Student.subscriptionPlan == '0'
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/choose_plan');
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Choose Subscription Plan",
                                  style: TextStyle(color: brown)),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(Icons.arrow_forward, color: brown),
                            ],
                          )))
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(Icons.bookmark, color: Color(0xFFDAA520)),
                            Text("${Student.subscriptionPlanLabel}")
                          ]),
                          Text(
                              "${Student.daysRemaining} day${Student.daysRemaining > 1 ? 's' : ''} remaining"),
                        ],
                      )),

              SizedBox(height: 20),

              // last watched lesson

              // free lessons
              Text("Free Lessons",
                  style: TextStyle(color: brown, fontWeight: FontWeight.bold)),

              Container(child: Column(children: _loadFreeLessons())),
            ]));
  }

  List<Widget> _loadFreeLessons() {
    // tutorial lessons
    tutorialLessons = freeLessons;
    List<Widget> vids = new List<Widget>();
    freeLessons.forEach((lesson) {
      vids.add(renderLesson(lesson, context, () {
        currentTutorial = lesson;
        Navigator.pushNamed(context, "/tutorial_page");
      }, courseLocked: false));
    });

    return vids;
  }
}

// shape: RoundedRectangleBorder(
//   borderRadius: new BorderRadius.circular(15.0),
//   side: BorderSide(color: brown)
// ),
