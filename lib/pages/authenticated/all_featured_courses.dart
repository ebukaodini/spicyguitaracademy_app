// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

// import the all and the studying
// import './all_courses.dart';
// import './studying_courses.dart';

class AllFeaturedCoursesPage extends StatefulWidget {
  @override
  AllFeaturedCoursesPageState createState() =>
      new AllFeaturedCoursesPageState();
}

class AllFeaturedCoursesPageState extends State<AllFeaturedCoursesPage> {
  @override
  void initState() {
    super.initState();
  }

  int _courseCategory = 1;
  String _sortValue = "Order";

  // function to sort the courses either by tutor or by title
  void _sortCourses() {
    switch (_sortValue) {
      case 'Order':
        setState(() {
          Courses.sortByOrder(featuredCourses);
        });
        break;
      case 'Tutor':
        setState(() {
          Courses.sortByTutor(featuredCourses);
        });
        break;
      case 'Title':
        setState(() {
          Courses.sortByTitle(featuredCourses);
        });
        break;
      default:
        setState(() {
          Courses.sortByOrder(featuredCourses);
        });
        break;
    }
  }

  Widget _loadCourses() {
    List<Widget> vids = [];

    // add the image for the category
    vids.add(Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
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

    featuredCourses.forEach((course) {
      vids.add(renderCourse(course, context, () async {
        try {
          loading(context);
          if (course.status == true) {
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
          } else {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/coursepreview_page', arguments: {
              'course': course,
            });
          }
        } catch (e) {
          Navigator.pop(context);
          error(context, stripExceptions(e));
        }
      }, showProgress: false, showPricings: true));
    });

    return new Column(children: vids);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      // The top text
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // description text
          Text(
            "Buy\nCourses",
            // "Featured\nCourses",
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

      _loadCourses()
    ]));
  }
}
