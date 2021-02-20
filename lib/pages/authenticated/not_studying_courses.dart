import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotStyudyingCoursesPage extends StatefulWidget{

  NotStyudyingCoursesPage();

  @override
  NotStyudyingCoursesPageState createState() => new NotStyudyingCoursesPageState();
}

class NotStyudyingCoursesPageState extends State<NotStyudyingCoursesPage> {

  NotStyudyingCoursesPageState();

  @override
  void initState() {
    super.initState();
  }

  final categoryThumbnails = ["assets/imgs/pictures/beginners_thumbnail.jpg", "assets/imgs/pictures/amateur_thumbnail.jpg", "assets/imgs/pictures/intermediate_thumbnail.jpg", "assets/imgs/pictures/advanced_thumbnail.jpg"];

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      body: OrientationBuilder(
        
        builder: (context, orientation) {
          
          // All Page
          return 
          SingleChildScrollView(
            child: Column(
              
              children: <Widget>[

                Container(
                  margin: EdgeInsets.symmetric(vertical: 50 ), 
                  width: 150,
                  height: 150,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: ExactAssetImage("assets/imgs/pictures/not_studying.jpg"),
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(250)),
                  ),
                ),

                Text(
                  "No Courses!",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color.fromRGBO(107, 43, 20, 1.0),
                    fontWeight: FontWeight.w500
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  child: Text(
                    "Choose a course from the Coures tab or use the button below to start.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(112, 112, 112, 0.5),
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, right: 5),
                  child: 
                  MaterialButton(
                    minWidth: 15, 
                    color: Color.fromRGBO(107, 43, 20, 1.0),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    onPressed: () => setState(() {
                      // _sortCourses();
                    }),
                    child: Icon(Icons.add, color: Colors.white, size: 25.0,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),



              ]
          
            ),
          );
 
        }
      )
    );
  }

}
