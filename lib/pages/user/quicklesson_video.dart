import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
// import 'package:video_player/video_player.dart';

class QuickLessonVideo extends StatefulWidget{

  QuickLessonVideo();

  @override
  QuickLessonVideoState createState() => new QuickLessonVideoState();
}

class QuickLessonVideoState extends State<QuickLessonVideo>{

  // video controller
  // VideoPlayerController _controller;
  // properties
  // bool courseLocked = true;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.asset('assets/tutorials/videos/sample_low_video.mp4');

    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(true);
    // _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  String thumbnail = "assets/imgs/pictures/course_img_default.jpg";
  String tutor = "Lionel Lionel";
  String title = "Strumming";
  String description = "Learn how to strum strings easily.";

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      body: OrientationBuilder(
        
        builder: (context, orientation) {
          return 
          SafeArea(
            minimum: EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: 
              Column(
                children: <Widget>[

                  // course title and the number of lessons
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 17, right: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        // back button
                        Container(
                          // alignment: Alignment.topLeft,
                          
                          child: MaterialButton(
                            minWidth: 20,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            onPressed: (){ Navigator.pop(context);},
                            child: new Icon(Icons.arrow_back_ios, color: Color.fromRGBO(107, 43, 20, 1.0), size: 20.0,),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white)
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  // the video
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    padding: EdgeInsets.only(bottom: 40),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0 )
                      ],
                    ),
                    child: 
                    Column(
                      children: <Widget>[
                        
                        // add the thumbnail for the lesson
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).copyWith().size.width,
                          height: 200.00,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: ExactAssetImage(thumbnail),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: 
                          SvgPicture.asset(
                            "assets/imgs/icons/play_video_icon.svg",
                            color: Colors.white,
                            fit: BoxFit.scaleDown,
                          ),
                          // Column(children: <Widget>[
                          //   VideoPlayer(_controller),
                          //   _PlayPauseOverlay(controller: _controller),
                          //   VideoProgressIndicator(_controller, allowScrubbing: true),
                          // ],)
                        ),

                        // The text contents
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Container(
                              width: orientation == Orientation.portrait ? 300 : 650,
                              child: Text(
                                title, 
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
                                tutor,
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
                                description, 
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
                

                ],
              )
              
            )
          );
        }
      )
    );

  }

}

// class _PlayPauseOverlay extends StatelessWidget {
//   const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

//   final VideoPlayerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: Duration(milliseconds: 50),
//           reverseDuration: Duration(milliseconds: 200),
//           child: controller.value.isPlaying
//               ? SizedBox.shrink()
//               : Container(
//                   color: Colors.black26,
//                   child: Center(
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 100.0,
//                     ),
//                   ),
//                 ),
//         ),
//         GestureDetector(
//           onTap: () {
//             controller.value.isPlaying ? controller.pause() : controller.play();
//           },
//         ),
//       ],
//     );
//   }
// }