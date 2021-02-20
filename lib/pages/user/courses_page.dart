import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'dart:math';

// import the all and the studying
import './all_courses.dart';
import './studying_courses.dart';
import './not_studying_courses.dart';

class CoursesPage extends StatefulWidget{

  CoursesPage();

  @override
  CoursesPageState createState() => new CoursesPageState();
}

class CoursesPageState extends State<CoursesPage> with SingleTickerProviderStateMixin {

  CoursesPageState();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // TabController 
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    
    int _currentCourse = 4;
    
    return new Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      body: OrientationBuilder(
        
        builder: (context, orientation) {
          
          return SafeArea(
            child: new Scaffold(
              backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
              
              appBar: new PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: 
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30)
                    ),
                  ),
                  child: 
                  TabBar(
                    controller: _tabController,
                    onTap: (index) {},
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      ),
                      color: Color.fromRGBO(107, 43, 20, 1.0),
                    ),
                    unselectedLabelColor: Color.fromRGBO(107, 43, 20, 1.0),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                    
                    tabs: <Widget>[
                      
                      Tab(
                        child: Text(
                          "ALL",
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ),

                      Tab(
                        child: Text(
                          "STUDYING",
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ),
                    
                    ],
                  ),
                ),
              ),
              
              body:
              SafeArea(
                minimum: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
                
                child: TabBarView(
                  dragStartBehavior: DragStartBehavior.start,
                  controller: _tabController,
                  children: <Widget>[
                    // _tabController.index.toString()

                    // All Page
                    new AllCoursesPage(),

                    // Studying Page
                    _currentCourse == 0 ? new NotStyudyingCoursesPage() : new StyudyingCoursesPage(),

                  ]

                )
              )
            )
          );

        }
      )
    );
  }

}
