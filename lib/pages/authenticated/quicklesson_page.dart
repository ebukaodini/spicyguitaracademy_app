import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class QuickLessonsPage extends StatefulWidget {
  final Orientation orientation;
  QuickLessonsPage(this.orientation);

  @override
  QuickLessonsPageState createState() => new QuickLessonsPageState(orientation);
}

class Lessons {
  // the properties on the class
  String thumbnail, tutor, title, description, lessons;
  // the constructor
  Lessons(this.thumbnail, this.tutor, this.title, this.description);

  // constructing from json
  Lessons.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    tutor = json['tutor'];
    title = json['title'];
    description = json['description'];
  }
}

parseLessons(_courses) {
  var lessons = <dynamic>[];
  for (var course in _courses) {
    lessons.add(new Lessons.fromJson(course));
  }
  return lessons;
}

class QuickLessonsPageState extends State<QuickLessonsPage> {
  Orientation orientation;
  QuickLessonsPageState(this.orientation);

  // properties
  // all these variables should be abstracted in a class and used globally
  bool _notificationsExist = true;

  @override
  void initState() {
    super.initState();
    print(Courses.allQuickLessons);
  }

  final courseLessons = parseLessons(Courses.allQuickLessons);

  String _sortValue = "Tutor";
  // function to sort the courses either by tutor or by title
  void _sortCourses() {
    if (_sortValue == "Tutor") {
      setState(() {
        courseLessons.sort((a, b) => a.tutor.compareTo(b.tutor));
        _sortValue = "Title";
      });
    } else {
      setState(() {
        courseLessons.sort((a, b) => a.title.compareTo(b.title));
        _sortValue = "Tutor";
      });
    }
  }

  Widget _indicateNotifications() {
    if (_notificationsExist == true) {
      return Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.notifications_none,
              size: 30,
              color: Color.fromRGBO(107, 43, 20, 1.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 15, left: 15),
              child: Icon(
                Icons.fiber_manual_record,
                size: 15,
                color: Colors.green,
              ))
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.notifications_none,
              size: 30,
              color: Color.fromRGBO(107, 43, 20, 1.0),
            ),
          ),
        ],
      );
    }
  }
  
  Widget _headerWidget(orientation) {
    return Container(
      margin: EdgeInsets.only(
          top: orientation == Orientation.portrait ? 30.0 : 10.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonTheme(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 0,
              height: 0,
              child: FlatButton(
                child: new Icon(
                  Icons.menu,
                  size: 30,
                  color: Color.fromRGBO(107, 43, 20, 1.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.pushNamed(context, "/welcome_note");
                },
              )),
          Row(children: <Widget>[
            ButtonTheme(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 0,
                height: 0,
                child: FlatButton(
                  child:
                      // the function would return a bell and a green dot if there's a notification, else it would only a bell
                      _indicateNotifications(),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () => setState(() {
                    _notificationsExist = false;
                    // Navigator.pushNamed(context, "/notifications_page");
                  }),
                )),
            MaterialButton(
                onPressed: () => Navigator.pushNamed(context, "/userprofile"),
                child: CircleAvatar(
                  // backgroundColor: Colors.white,
                  radius: 25,
                  backgroundColor: Color.fromRGBO(107, 43, 20, 1.0),
                  backgroundImage: NetworkImage('${App.appurl}/${User.avatar}')
                ))
          ]),
        ],
      ),
    );
  }

  Widget _loadLessons(orientation) {
    List<Widget> vids = new List<Widget>();
    courseLessons.toList().forEach((lesson) {

      lesson = new Lessons(lesson['thumbnail'], lesson["tutor"],
          lesson["lesson"], lesson["description"]);

      vids.add(new CupertinoButton(
        onPressed: () {
          Navigator.pushNamed(context, "/quicklesson_video");
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                child: SvgPicture.asset(
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
                      overflow: TextOverflow.ellipsis,
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
      ));
    });

    return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: vids);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: OrientationBuilder(builder: (context, orientation) {
          // All Page
          return SingleChildScrollView(
            child: Column(children: <Widget>[
              _headerWidget(orientation),

              // The top text
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // description text
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Featured",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Videos",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    ),

                    // the sort button
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 5),
                      child: MaterialButton(
                        minWidth: 15,
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        onPressed: () => setState(() {
                          _sortCourses();
                        }),
                        child: Transform.rotate(
                          angle: pi / 2,
                          child: Icon(
                            Icons.tune,
                            color: Color.fromRGBO(107, 43, 20, 1.0),
                            size: 25.0,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          // side: BorderSide(color: Color.fromRGBO(107, 43, 20, 1.0))
                        ),
                      ),
                    )
                  ],
                ),
              ),

              _loadLessons(orientation)
            ]),
          );
        }));
  }
}
