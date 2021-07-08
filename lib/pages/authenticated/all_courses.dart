// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

// import the all and the studying
// import './all_courses.dart';
// import './studying_courses.dart';

class AllCoursesPage extends StatefulWidget {
  @override
  AllCoursesPageState createState() => new AllCoursesPageState();
}

class AllCoursesPageState extends State<AllCoursesPage> {
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
          Courses.sortByOrder(beginnersCourses);
          Courses.sortByOrder(amateurCourses);
          Courses.sortByOrder(intermediateCourses);
          Courses.sortByOrder(advancedCourses);
        });
        break;
      case 'Tutor':
        setState(() {
          Courses.sortByTutor(beginnersCourses);
          Courses.sortByTutor(amateurCourses);
          Courses.sortByTutor(intermediateCourses);
          Courses.sortByTutor(advancedCourses);
        });
        break;
      case 'Title':
        setState(() {
          Courses.sortByTitle(beginnersCourses);
          Courses.sortByTitle(amateurCourses);
          Courses.sortByTitle(intermediateCourses);
          Courses.sortByTitle(advancedCourses);
        });
        break;
      default:
        setState(() {
          Courses.sortByOrder(beginnersCourses);
          Courses.sortByOrder(amateurCourses);
          Courses.sortByOrder(intermediateCourses);
          Courses.sortByOrder(advancedCourses);
        });
        break;
    }
  }

  loadLessons(Course course) async {
    // if (Student.studyingCategory == (_courseCategory + 1)) {
    //   // loading(context);
    //   List<dynamic> lessons =
    //       await Lessons.getLessons(context, course.id);
    //   Navigator.pop(context);
    //   Navigator.pushNamed(context, "/allcourses_lessons", arguments: {
    //     'courseLessons': lessons,
    //     'courseTitle': course.title,
    //     'noLessons': course.allLessons ?? 0
    //   });
    // }
  }

  Widget _loadCourses() {
    List<Widget> vids = [];
    List<dynamic> videos;

    switch (_courseCategory) {
      case 1:
        videos = beginnersCourses;
        break;
      case 2:
        videos = amateurCourses;
        break;
      case 3:
        videos = intermediateCourses;
        break;
      case 4:
        videos = advancedCourses;
        break;
      default:
        videos = beginnersCourses;
        break;
    }

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

    videos.forEach((course) {
      vids.add(renderCourse(course, context, () => {}, showProgress: false));
    });

    return new Column(children: vids);
  }

  Widget categoryIdentification(category, categoryLabel) {
    return InkWell(
      onTap: () {
        setState(() {
          _courseCategory = category;
        });
      },
      child: Container(
        // width: screen(context).width * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$categoryLabel',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _courseCategory == category ? brown : darkgrey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                width: 40,
                height: 5,
                color: _courseCategory == category ? brown : Colors.transparent)
          ],
        ),
      ),
    );
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
            "Find Amazing\nCourses",
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

      // the category identification
      Container(
        width: screen(context).width,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            categoryIdentification(1, 'Beginners'),
            categoryIdentification(2, 'Amateurs'),
            categoryIdentification(3, 'Intermediates'),
            categoryIdentification(4, 'Advanced')
          ],
        ),
      ),

      _loadCourses()
    ]));
  }
}
