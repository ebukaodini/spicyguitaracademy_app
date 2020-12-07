// import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/cupertino.dart';
// // import 'package:http/http.dart' as http;
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

// class TutorialTab extends StatefulWidget{

//   TutorialTab();

//   @override
//   TutorialTabState createState() => new TutorialTabState();
// }

// class TutorialTabState extends State<TutorialTab>{

//   // String pdfAsset = ;
//   PDFDocument document;
//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadPDF();
//   }

//   loadPDF() async {
//     setState(() {
//       _loading = true;
//     });
//     document = await PDFDocument.fromAsset("assets/tutorials/tabs/sample_tab.pdf");
//     setState(() {
//       _loading = false;
//     });
//   }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   // }

//   String tutor = "Lionel Lionel";
//   String title = "Strumming";
//   String description = "Learn how to strum strings easily.";

//   @override
//   Widget build(BuildContext context) {
    
//     return new Scaffold(
//       backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
//       body: 
//       // OrientationBuilder(
        
//       //   builder: (context, orientation) {
//       //     return 
//           // SafeArea(
//           //   minimum: EdgeInsets.only(top: 20),
//             // child: 
//             SingleChildScrollView(
//               child: 
//               Column(
//                 children: <Widget>[

//                   // course title and the number of lessons
//                   Container(
//                     margin: EdgeInsets.only(top: 45, left: 17, right: 17),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
                        
//                         // back button
//                         Container(
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

//                       ],
//                     ),
//                   ),

//                   // Tablature
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                     // padding: EdgeInsets.only(bottom: 10),
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
                        
//                         // The text contents
//                         Container(
//                           margin: EdgeInsets.symmetric(vertical: 30),
//                           child: 
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[

//                               Container(
//                                 // width: orientation == Orientation.portrait ? 300 : 650,
//                                 child: Text(
//                                   title, 
//                                   // textAlign: TextAlign.left,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     color: Color.fromRGBO(107, 43, 20, 1.0),
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),

//                               ),

//                               Container(
//                                 margin: EdgeInsets.only(top: 3, bottom: 10),
//                                 child: Text(
//                                   tutor,
//                                   // textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: Color.fromRGBO(112, 112, 112, 0.5),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),

//                               Container(
//                                 // width: orientation == Orientation.portrait ? 300 : 650,
//                                 child: Text(
//                                   description, 
//                                   overflow: TextOverflow.visible,
//                                   style: TextStyle(
//                                     color: Color.fromRGBO(112, 112, 112, 1.0),
//                                     fontSize: 15.0,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
                              
//                             ],
//                           ),
//                         ),

//                         // the pdf section for the tab
//                         Container(
//                           // margin: EdgeInsets.only(bottom: 10),
//                           // width: MediaQuery.of(context).copyWith().size.width,
//                           height: MediaQuery.of(context).copyWith().size.height - 290,
//                           // height: 500,
//                           // decoration: new BoxDecoration(
//                           //   borderRadius: BorderRadius.all(Radius.circular(25)),
//                           // ),
//                           child: _loading ? Center(child: CircularProgressIndicator())
//                           : PDFViewer(
//                             document: document, 
//                             indicatorBackground: Color.fromRGBO(107, 43, 20, 1.0),
//                             showPicker: false,
//                           ),
//                         ),

//                       ],
//                     ),
//                   ),
                

//                 ],
//               )
//               // ;
              
//             )
//           // );
//       //   }
//       // )
//     );

//   }

// }