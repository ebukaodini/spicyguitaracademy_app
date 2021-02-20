import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';
// import 'dart:convert' as json;

class HomePage extends StatefulWidget {
  final Orientation orientation;
  HomePage(this.orientation);

  @override
  HomePageState createState() => new HomePageState(orientation);
}

class Lesson {
  // the properties on the class
  String thumbnail, tutor, title, description, id;

  // constructing from json
  Lesson.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] ?? '';
    tutor = json['tutor'] ?? '';
    title = json['lesson'] ?? '';
    description = json['description'] ?? '';
    id = json['id'] ?? '';
  }
}

parseLessons() {
  var freelessons = Courses.freeLessons;
  var lessons = <dynamic>[];
  for (var lesson in freelessons) {
    lessons.add(new Lesson.fromJson(lesson));
  }
  return lessons;
}

class HomePageState extends State<HomePage> {
  Orientation orientation;
  HomePageState(this.orientation);

  // properties
  // all these variables should be abstracted in a class and used globally
  String _firstname = User.firstname;
  bool _notificationsExist = false;

  final lessons = parseLessons();

  // local properties
  bool _filterFocused = false;

  // sort & filter option
  List<String> _sortOptions = ['Title', 'Tutor'];
  String _sortValue = 'Title';
  // String _filterValue = "";

  @override
  void initState() {
    super.initState();
    _notJustLoggedIn();
  }

  void _sortLessons() {
    setState(() {
      if (_sortValue == "Tutor")
        lessons
            .sort((a, b) => a.tutor.toString().compareTo(b.tutor.toString()));
      // lessons.sort();
      else if (_sortValue == "Title")
        lessons
            .sort((a, b) => a.title.toString().compareTo(b.title.toString()));
      // lessons.sort();
    });
  }

  void _notJustLoggedIn() {
    Timer(
        const Duration(seconds: 5),
        () => setState(() {
              User.justLoggedIn = false;
            }));
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
    if (User.justLoggedIn == false) {
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
                    // ScaffoldState.openEndDrawer();
                    Scaffold.of(context).openDrawer();
                    // Navigator.pushNamed(context, "/welcome_note");
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
                      backgroundImage:
                          NetworkImage('${App.appurl}/${User.avatar}')))
            ]),
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: orientation == Orientation.portrait ? 90.0 : 30.0,
                bottom: 10),
            alignment: Alignment.center,
            child: Text(
              "Hi, " + _firstname,
              style: TextStyle(
                color: Color.fromRGBO(107, 43, 20, 1.0),
                fontSize: 33.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              "What would you like to learn today? search below.",
              style: TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1.0),
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              strutStyle: StrutStyle(
                fontSize: 20.0,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
  }

  Widget _loadFeaturedVideos() {
    List<Widget> vids = new List<Widget>();

    // Map<String, dynamic> lessonsParsed = json.jsonDecode(lessonsJson);
    // Lessons lessons = Lessons.fromJson(lessonsParsed);

    _sortLessons();

    lessons.forEach((lesson) {
      // print('\n\n'+'\n\n');
      vids.add(new Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: CupertinoButton(
            onPressed: () {},
            child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 70),
                    width: MediaQuery.of(context).copyWith().size.width - 100,
                    height: 160.00,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 2.0)
                      ],
                    ),
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 60, right: 3, top: 30, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              lesson.tutor,
                              style: TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 1.0),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              lesson.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                fontSize: 25.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              lesson.description,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 1.0),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ))),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 120.00,
                  height: 120.00,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage('${App.appurl}/${lesson.thumbnail}'),
                      fit: BoxFit.fitHeight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7.0,
                          spreadRadius: 5.0)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
              ],
            )),
      ));
    });

    return new Column(children: vids);
  }

  Widget _selectFilter() {
    if (_filterFocused == true) {
      // Return the dropdown option for sorting and filtering
      return Container(
        height: 70,
        width: MediaQuery.of(context).copyWith().size.width - 120,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Sort by",
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1.0),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                DropdownButton<String>(
                  value: _sortValue,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromRGBO(107, 43, 20, 1.0),
                  ),
                  iconSize: 40,
                  elevation: 16,
                  style: TextStyle(
                    color: Color.fromRGBO(107, 43, 20, 1.0),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  underline: Container(),
                  onChanged: (String newValue) {
                    setState(() {
                      _sortValue = newValue;
                      _sortLessons();
                    });
                  },
                  items: _sortOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      // Return the search button that redirects to the search page
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0)
          ],
        ),
        child: MaterialButton(
          height: 60,
          minWidth: MediaQuery.of(context).copyWith().size.width - 120,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          onPressed: () {
            // navigate to search page
            Navigator.pushNamed(context, "/search_page");
          },
          child: Row(
            children: <Widget>[
              new Icon(
                Icons.search,
                color: Color.fromRGBO(112, 112, 112, 1.0),
                size: 22.0,
              ),
              Text(
                "Search",
                style: TextStyle(
                  color: Color.fromRGBO(112, 112, 112, 1.0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
            // side: BorderSide(color: Colors.white)
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(

            // child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          _headerWidget(orientation),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              // padding: EdgeInsets.symmetric(horizontal: 35),
              // height: 10000 , //orientation == Orientation.portrait ? MediaQuery.of(context).copyWith().size.height: 600,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Search container
                  Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _selectFilter(),
                          Container(
                            height: 60,
                            child: MaterialButton(
                              minWidth: 20,
                              color: !_filterFocused
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Color.fromRGBO(71, 29, 14, 1.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 18),
                              onPressed: () => setState(() {
                                _filterFocused = !_filterFocused;
                                // names.sort();
                                // names.add("Emmanuel");
                              }),
                              child: Transform.rotate(
                                angle: pi / 2,
                                child: new Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0))),
                            ),
                          ),
                        ],
                      )),

                  _loadFeaturedVideos()
                ],
              ),
            ),
          ),
        ])
        // )
        ;
  }
}

// shape: RoundedRectangleBorder(
//   borderRadius: new BorderRadius.circular(15.0),
//   side: BorderSide(color: Color.fromRGBO(107, 43, 20, 1.0))
// ),
