// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class MyFeaturedCoursesPage extends StatefulWidget {
  @override
  MyFeaturedCoursesPageState createState() => new MyFeaturedCoursesPageState();
}

class MyFeaturedCoursesPageState extends State<MyFeaturedCoursesPage> {
  String _sortValue = "Order";
  int _courseCategory = 0;
  // dynamic courses;

  @override
  void initState() {
    super.initState();
  }

  void _sortCourses() {
    switch (_sortValue) {
      case 'Order':
        setState(() {
          Courses.sortByOrder(myFeaturedCourses);
        });
        break;
      case 'Tutor':
        setState(() {
          Courses.sortByTutor(myFeaturedCourses);
        });
        break;
      case 'Title':
        setState(() {
          Courses.sortByTitle(myFeaturedCourses);
        });
        break;
      default:
        setState(() {
          Courses.sortByOrder(myFeaturedCourses);
        });
        break;
    }
  }

  Widget _loadCourses() {
    List<Widget> vids = [];

    // var videos;
    // // _sortCourses();
    // videos = courses;

    // add the image for the category
    vids.add(Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: screen(context).width,
      height: 120,
      decoration: new BoxDecoration(
        border:
            Border.all(color: darkgrey, width: 1.0, style: BorderStyle.solid),
        image: new DecorationImage(
          image: ExactAssetImage(
              getStudentCategoryThumbnail(category: _courseCategory)),
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ));

    if (myFeaturedCourses.length > 0) {
      myFeaturedCourses.forEach((course) {
        vids.add(renderCourse(course, context, () async {
          try {
            // get the lessons on this course
            // and the assignments for the course
            loading(context);
            // await Lessons.getLessons(context, course.id);
            await Lessons.getFeaturedLessons(context, course.id);
            await Courses.getAssigment(context, course.id);
            Lessons.source = LessonSource.featured;
            Courses.currentCourse = course;
            Navigator.pop(context);
            Navigator.pushNamed(context, "/lessons_page", arguments: {
              'courseTitle': course.title,
              'courseActive': course.status,
              'courseId': course.id,
            });
          } catch (e) {
            Navigator.pop(context);
            error(context, stripExceptions(e));
          }
        }));
      });
    } else {
      vids.add(new Container(
          child: Text("Sorry, there are no courses at the moment")));
    }

    return new Column(children: vids);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      // The top text
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // description text
            Text(
              "Bought\nCourses",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30.0, color: brown, fontWeight: FontWeight.w500),
            ),

            // the sort button
            Container(
              // margin: EdgeInsets.only(top: 10, right: 5),
              child: MaterialButton(
                minWidth: 30,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                onPressed: () {
                  List<String> sortValues = ['Order', 'Title', 'Tutor'];
                  setState(() {
                    _sortValue = _sortValue == 'Tutor'
                        ? 'Order'
                        : sortValues[sortValues.indexOf(_sortValue) + 1];
                    _sortCourses();
                  });
                },
                child: Row(children: [
                  Text(
                    "$_sortValue",
                    style: TextStyle(color: brown, fontSize: 16),
                  ),
                  Icon(
                    Icons.sort,
                    color: brown,
                  ),
                ]),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          ],
        ),
      ),

      _loadCourses()
    ]));
  }
}
