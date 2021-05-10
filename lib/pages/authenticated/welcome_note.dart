import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class WelcomeNotePage extends StatefulWidget {
  @override
  WelcomeNotePageState createState() => new WelcomeNotePageState();
}

class WelcomeNotePageState extends State<WelcomeNotePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            minimum: EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Container(
                // alignment: Alignment.topLeft,
                // margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.symmetric(horizontal: 30),
                // decoration: BoxDecoration(
                //   borderRadius: new BorderRadius.only(
                //       topLeft: Radius.circular(25),
                //       topRight: Radius.circular(25)),
                //   color: Colors.white,
                // ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      Text(
                        "Hi, ${Student.firstname}",
                        style: TextStyle(
                          color: brown,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        child: Text(
                          "You are welcome to Spicy Guitar Academy.",
                          style: TextStyle(
                              color: brown,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          "Spicy Guitar Academy is aimed at guiding beginners to fulfill their dreams of becoming professional guitar players.\n\nWe have the best qualified tutors who are dedicated to help you develop from start to finish to make your dreams come true.",
                          style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1.0),
                            fontSize: 20.0,
                            // fontWeight: FontWeight.bold,
                          ),
                          strutStyle: StrutStyle(
                            fontSize: 20.0,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 60),
                      Container(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                            onPressed: () {
                              if (Student.subscription == true) {
                                Navigator.pushNamed(context, '/ready_to_play');
                              } else {
                                Navigator.pushNamed(context, '/choose_plan');
                              }
                            },
                            color: brown,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text("Continue",
                                style: TextStyle(fontSize: 20.0))),
                      ),
                      SizedBox(height: 50.0)
                    ]),
              ),
            )));
  }
}
