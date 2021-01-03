import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import '../../services/app.dart';
import './home_page.dart';
import './courses_page.dart';
import './quicklesson_page.dart';
import './userprofile_page.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {

  int _currentPage = 0;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new 
    Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      body: 
      OrientationBuilder(
        builder: (context, orientation) {
          
          final _pageOptions = [
            new HomePage(orientation),
            new CoursesPage(),
            new QuickLessonsPage(orientation),
            new UserProfilePage(),
          ];

          return 
          SafeArea(
            minimum: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
            child: _pageOptions[_currentPage],
          );
        }
      ),
      
      endDrawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(height: 36),
            ListTile(
              title: Text('Load from Assets'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: Text('Load from URL'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: Text('Restore default'),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: 
      Container(
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromRGBO(107, 43, 20, 1.0),
          border: new Border.all(
            color: Color.fromRGBO(107, 43, 20, 1.0),
            width: 1.0,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        
        child: BottomNavigationBar(
          currentIndex: _currentPage,
          onTap: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          iconSize: 35.0,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.shifting,
          elevation: 0,
          
          items: [

            BottomNavigationBarItem(
              // backgroundColor: Color.fromRGBO(107, 43, 20, 1.0),
              backgroundColor: Colors.transparent,
              label: 'Home',
              icon: Container(
                margin: EdgeInsets.symmetric(vertical:10),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/home_icon.svg",
                  matchTextDirection: true,
                ),
              ),
              activeIcon: Container(
                margin: EdgeInsets.symmetric(vertical:3),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  ),
                ),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/home_icon_active.svg",
                  matchTextDirection: true,
                ),
              ),
            ),

            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              label: 'Courses',
              icon: Container(
                margin: EdgeInsets.symmetric(vertical:10),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/courses_icon.svg",
                  matchTextDirection: true,
                ),
              ),
              activeIcon: Container(
                margin: EdgeInsets.symmetric(vertical:3),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  ),
                ),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/courses_icon_active.svg",
                  matchTextDirection: true,
                ),
              ),
            ),

            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              label: 'Featured',
              icon: Container(
                margin: EdgeInsets.symmetric(vertical:10),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/video_icon.svg",
                  matchTextDirection: true,
                ),
              ),
              activeIcon: Container(
                margin: EdgeInsets.symmetric(vertical:3),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  ),
                ),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/video_icon_active.svg",
                  matchTextDirection: true,
                ),
              ),
            ),

            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              label: 'Profile',
              icon: Container(
                margin: EdgeInsets.symmetric(vertical:10),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/user_icon.svg",
                  matchTextDirection: true,
                ),
              ),
              activeIcon: Container(
                margin: EdgeInsets.symmetric(vertical:3),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  ),
                ),
                child: 
                SvgPicture.asset(
                  "assets/imgs/icons/user_icon_active.svg",
                  matchTextDirection: true,
                ),
              ),
            ),

          ]

        ),

      )
      
    );
 
    
  }

}




    // Material(
    //   borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    //   // borderRadius: BorderRadius.all(Radius.circular(15)),
    //   // color: Colors.white,
    //   color: Color.fromRGBO(107, 43, 20, 1.0),
    //   child: 
    //   Container(
    //     height: 60,
    //     // alignment: Alignment.topCenter,
        
    //     child: new TabBar(

    //       // labelColor: Colors.redAccent,
    //       // unselectedLabelColor: Colors.white,
    //       indicatorSize: TabBarIndicatorSize.tab,
    //       indicator: BoxDecoration(
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(15),
    //           topRight: Radius.circular(15),
    //           // bottomLeft: Radius.circular(15),
    //           // bottomRight: Radius.circular(15)
    //         ),
    //         color: Colors.white
    //       ),

    //       controller: controller,
    //       tabs: <Tab> [

    //         new Tab(
    //           child: SvgPicture.asset(
    //             "assets/imgs/icons/home_icon.svg",
    //             matchTextDirection: true,
    //           ),
    //         ),

    //         new Tab(
    //           child: SvgPicture.asset(
    //             "assets/imgs/icons/courses_icon.svg",
    //             matchTextDirection: true,
    //           ),
    //         ),

    //         new Tab(
    //           child: SvgPicture.asset(
    //             "assets/imgs/icons/video_icon.svg",
    //             matchTextDirection: true,
    //           ),
    //         ),

    //         new Tab(
    //           child: 
    //           Container(
    //             // padding: EdgeInsets.all(15),
    //             // alignment: Alignment.topCenter,
    //             // height: ,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //               // topLeft: Radius.circular(15),
    //               // topRight: Radius.circular(15),
    //               // bottomLeft: Radius.circular(15),
    //               // bottomRight: Radius.circular(15)
    //             ),
    //             color: Colors.white,
    //               // color: Color.fromRGBO(107, 43, 20, 1.0),
    //             ),
    //             child: 
    //             SvgPicture.asset(
    //               "assets/imgs/icons/user_icon.svg",
    //               matchTextDirection: true,
    //             ),
    //           ),
    //         ),

    //       ],
          
    //       onTap: (newIndex) {
    //         // setState(() => _index = newIndex);
    //         switch (newIndex) {
    //           case 0:
    //             Navigator.pushReplacementNamed(context, '/home_page');
    //             break;
    //           case 1:
    //             Navigator.pushReplacementNamed(context, '/courses_page');
    //             break;
    //           case 2:
    //             Navigator.pushReplacementNamed(context, '/featured_videos_page');
    //             break;
    //           case 3:
    //             Navigator.pushReplacementNamed(context, '/userprofile_page');
    //             break;
    //         }
    //       },

    //     ),
    //   )
      
    // );
  
//   }
// }