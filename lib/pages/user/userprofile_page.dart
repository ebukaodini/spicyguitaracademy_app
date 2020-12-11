import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:core';
import '../../services/app.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage();

  @override
  UserProfilePageState createState() => new UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  UserProfilePageState();

  @override
  void initState() {
    super.initState();
    print(User.categoryStats);
  }

  @override
  Widget build(BuildContext context) {
    String _name = User.firstname + ' ' + User.lastname;

    // external properties
    int _completedCourses = User.categoryStats['takenCourses'] ?? 0;
    int _totalCourses = User.categoryStats['allCourses'] ?? 0;
    int _completedLessons = User.categoryStats['takenLessons'] ?? 0;
    int _totalLessons = User.categoryStats['allLessons'] ?? 0;

    return new Scaffold(
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: OrientationBuilder(builder: (context, orientation) {
          return SafeArea(
            minimum: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              // Settings btn
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 10, right: 5.0, bottom: 10.0),
                  child: IconButton(
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.pushNamed(context, "/userprofile/settings");
                    },
                    icon: new Icon(
                      Icons.settings,
                      color: Color.fromRGBO(107, 43, 20, 1.0),
                      size: 30.0,
                    ),
                  )),

              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  // Avatar
                  Container(
                    margin: EdgeInsets.only(top: 1.0, bottom: 0.0),
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: NetworkImage('${App.appurl}/${User.avatar}'),
                        fit: BoxFit.fitHeight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(250)),
                    ),
                  ),

                  // Edit Btn
                  Container(
                      margin: EdgeInsets.only(top: 120),
                      width: 100,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white54),
                      child: MaterialButton(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.black38,
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          onPressed: () {})),
                ],
              ),

              // Display Name
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(107, 43, 20, 1.0),
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600)),
              ),

              // Number of courses
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(107, 43, 20, 1.0)),
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "$_completedCourses of $_totalCourses",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  )),

              // Number of lessons
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    "$_completedLessons of $_totalLessons lessons",
                    style: TextStyle(
                      color: Color.fromRGBO(112, 112, 112, 1.0),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  )),

              // Button Selections
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: <Widget>[
                    Container(
                        // margin: const EdgeInsets.only(top: 60.0),
                        child: Row(
                      mainAxisAlignment: orientation == Orientation.portrait
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          height: 150.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: orientation == Orientation.portrait
                                  ? 0.0
                                  : 20.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/rechoose_category');
                            },
                            color: Colors.white,
                            textColor: Color.fromRGBO(107, 43, 20, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/imgs/icons/category_icon.svg",
                                  matchTextDirection: true,
                                ),
                                Text("Category",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150.0,
                          height: 150.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: orientation == Orientation.portrait
                                  ? 0.0
                                  : 20.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 25),
                            onPressed: () {
                              Navigator.pushNamed(context, '/choose_plan',
                                  arguments: {'selectedplan': User.plan});
                            },
                            color: Colors.white,
                            textColor: Color.fromRGBO(107, 43, 20, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/imgs/icons/subscription_icon.svg",
                                  matchTextDirection: true,
                                ),
                                Text("Subscription",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),

                    // Make-do spacer
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                    ),

                    Container(
                        // margin: const EdgeInsets.only(top: 60.0),
                        child: Row(
                      mainAxisAlignment: orientation == Orientation.portrait
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          height: 150.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: orientation == Orientation.portrait
                                  ? 0.0
                                  : 20.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            onPressed: () {
                              Navigator.pushNamed(context, "/invite_friend");
                            },
                            color: Colors.white,
                            textColor: Color.fromRGBO(107, 43, 20, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/imgs/icons/invite_friend_icon.svg",
                                  matchTextDirection: true,
                                ),
                                Text("Invite a friend",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150.0,
                          height: 150.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: orientation == Orientation.portrait
                                  ? 0.0
                                  : 20.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 25),
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Color.fromRGBO(107, 43, 20, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/imgs/icons/help_circle_icon.svg",
                                  matchTextDirection: true,
                                ),
                                Text("Help",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),

              // Make-do spacer
              Container(
                margin: EdgeInsets.only(bottom: 30),
              ),
            ])),
          );
        }));
  }
}
