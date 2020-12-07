// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/cupertino.dart';
// // import 'package:video_player/video_player.dart';

// // Audio
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:audioplayer/audioplayer.dart';

// class TutorialPage extends StatefulWidget{

//   TutorialPage();

//   @override
//   TutorialPageState createState() => new TutorialPageState();
// }

// class TutorialPageState extends State<TutorialPage>{

//   // video controller
//   // VideoPlayerController _controller;
//   // properties
//   // bool courseLocked = true;

//   @override
//   void initState() {
//     super.initState();

//     // loadAudio
//     _load();
//     // _controller = VideoPlayerController.asset('assets/tutorials/videos/sample_low_video.mp4');

//     // _controller.addListener(() {
//     //   setState(() {});
//     // });
//     // _controller.setLooping(true);
//     // _controller.initialize().then((_) => setState(() {}));
//     // _controller.play();
//   }

//   // Audios
//   // _handleAudio() {
//   //   _positionSubscription = audioPlayer.onAudioPositionChanged.listen(
//   //     (p) => setState(() => position = p)
//   //   );

//   //   _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((s) {
//       // if (s == AudioPlayerState.PLAYING) {
//   //       setState(() => duration = audioPlayer.duration);
//   //     } else if (s == AudioPlayerState.STOPPED) {
//   //       onComplete();
//   //       setState(() {
//   //         position = duration;
//   //       });
//       // }
//   //   }, onError: (msg) {
//   //     setState(() {
//   //       playerState = PlayerState.stopped;
//   //       duration = new Duration(seconds: 0);
//   //       position = new Duration(seconds: 0);
//   //     });
//   //   });
//   // }

//   AudioPlayer audioPlayer = AudioPlayer();
//   String mp3Uri = "";

//   _load() async {
//     final ByteData data = await rootBundle.load("assets/tutorials/audios/sample_audio.mp3");
//     Directory tempDir = await getTemporaryDirectory();
//     File tempFile = File("${tempDir.path}/sample_audio.mp3");
//     await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
//     mp3Uri = tempFile.uri.toString();
//   }
  
//   _play() {
//     audioPlayer.play(mp3Uri);
//   }

//   _pause() {
//     audioPlayer.pause();
//   }

//   _stop() {
//     audioPlayer.stop();
//   }

//   @override
//   void dispose() {
//     // _controller.dispose();
//     super.dispose();
//   }

//   String thumbnail = "assets/imgs/pictures/course_img_default.jpg";
//   String tutor = "Lionel Lionel";
//   String title = "Strumming";
//   String description = "Learn how to strum strings easily.";

//   @override
//   Widget build(BuildContext context) {
    
//     return new Scaffold(
//       backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
//       body: OrientationBuilder(
        
//         builder: (context, orientation) {
//           return 
//           SafeArea(
//             minimum: EdgeInsets.only(top: 20),
//             child: SingleChildScrollView(
//               child: 
//               Column(
//                 children: <Widget>[

//                   // course title and the number of lessons
//                   Container(
//                     margin: EdgeInsets.only(top: 20, left: 17, right: 17),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
                        
//                         // back button
//                         Container(
//                           // alignment: Alignment.topLeft,
                          
//                           child: MaterialButton(
//                             minWidth: 20,
//                             color: Colors.white,
//                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                             onPressed: (){ Navigator.pop(context);},
//                             child: new Icon(Icons.arrow_back_ios, color: Color.fromRGBO(107, 43, 20, 1.0), size: 20.0,),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: new BorderRadius.circular(15.0),
//                               side: BorderSide(color: Colors.white)
//                             ),
//                           ),
//                         ),

//                         // Tablature
//                         Container(
//                           // alignment: Alignment.topRight,
//                           // margin: EdgeInsets.only(top: 20, right: 17),
//                           child: MaterialButton(
//                             // minWidth: 20,
//                             color: Color.fromRGBO(107, 43, 20, 1.0),
//                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//                             onPressed: (){ Navigator.pushNamed(context, '/tutorial_tab');},
//                             child: Text("Tablature", style: TextStyle(color: Colors.white),),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: new BorderRadius.circular(15.0),
//                               // side: BorderSide(color: Colors.white)
//                             ),
//                           ),
//                         ),

//                       ],
//                     ),
//                   ),

//                   // the video
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                     padding: EdgeInsets.only(bottom: 40),
//                     decoration: new BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(25)),
//                       boxShadow: [
//                         BoxShadow(color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0 )
//                       ],
//                     ),
//                     child: 
//                     Column(
//                       children: <Widget>[
                        
//                         // add the thumbnail for the lesson
//                         Container(
//                           margin: EdgeInsets.only(bottom: 10),
//                           width: MediaQuery.of(context).copyWith().size.width,
//                           height: 200.00,
//                           decoration: new BoxDecoration(
//                             image: new DecorationImage(
//                               image: ExactAssetImage(thumbnail),
//                               fit: BoxFit.fitWidth,
//                             ),
//                             borderRadius: BorderRadius.all(Radius.circular(25)),
//                           ),
//                           child: 
//                           SvgPicture.asset(
//                             "assets/imgs/icons/play_video_icon.svg",
//                             color: Colors.white,
//                             fit: BoxFit.scaleDown,
//                           ),
//                           // Column(children: <Widget>[
//                           //   VideoPlayer(_controller),
//                           //   _PlayPauseOverlay(controller: _controller),
//                           //   VideoProgressIndicator(_controller, allowScrubbing: true),
//                           // ],)
//                         ),

//                         // The text contents
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[

//                             Container(
//                               width: orientation == Orientation.portrait ? 300 : 650,
//                               child: Text(
//                                 title, 
//                                 // textAlign: TextAlign.left,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Color.fromRGBO(107, 43, 20, 1.0),
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),

//                             ),

//                             Container(
//                               margin: EdgeInsets.only(top: 3, bottom: 10),
//                               child: Text(
//                                 tutor,
//                                 // textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromRGBO(112, 112, 112, 0.5),
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),

//                             Container(
//                               width: orientation == Orientation.portrait ? 300 : 650,
//                               child: Text(
//                                 description, 
//                                 overflow: TextOverflow.visible,
//                                 style: TextStyle(
//                                   color: Color.fromRGBO(112, 112, 112, 1.0),
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
                            
//                           ],
//                         )

//                       ],
//                     ),
//                   ),
                
//                   // the audio
//                   Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         MaterialButton(onPressed: _play(), child: Text("PLAY"),),

//                         MaterialButton(onPressed: _pause(), child: Text("PAUSE"),),

//                         MaterialButton(onPressed: _stop(), child: Text("STOP"),),
//                       ]
                      
//                     )
//                   ),

//                 ],
//               )
              
//             )
//           );
//         }
//       )
//     );

//   }

// }
