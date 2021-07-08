import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';
// import the all and the studying
import 'package:spicyguitaracademy/pages/authenticated/all_featured_courses.dart';
import 'package:spicyguitaracademy/pages/authenticated/my_featured_courses.dart';
import 'package:spicyguitaracademy/pages/authenticated/no_featured_courses.dart';

class FeaturedCoursesPage extends StatefulWidget {
  FeaturedCoursesPage();

  @override
  FeaturedCoursesPageState createState() => new FeaturedCoursesPageState();
}

class FeaturedCoursesPageState extends State<FeaturedCoursesPage>
    with SingleTickerProviderStateMixin {
  FeaturedCoursesPageState();

  TabController _tabController;
  int tabPageIndex = 0;
  List<dynamic> tabPageOption = [
    // Studying Page
    Student.studyingCategory == 0
        ? NoFeaturedCoursesPage()
        : MyFeaturedCoursesPage(),
    AllFeaturedCoursesPage()
  ];

  @override
  void initState() {
    super.initState();
    // TabController
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() => tabPageIndex = index);
              },
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: brown,
              ),
              unselectedLabelColor: brown,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
              tabs: <Widget>[
                Tab(
                    child: Text(
                  "BOUGHT COURSES",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
                Tab(
                    child: Text(
                  "BUY COURSES",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
              ],
            ),
          ),
        ),
        body: TabBarView(
            dragStartBehavior: DragStartBehavior.start,
            controller: _tabController,
            children: <Widget>[
              // Bought Page
              myFeaturedCourses.length == 0
                  ? NoFeaturedCoursesPage()
                  : MyFeaturedCoursesPage(),

              // All Page
              AllFeaturedCoursesPage(),
            ]));
  }
}
