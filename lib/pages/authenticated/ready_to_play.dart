import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class ReadyToPlayTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOver,
              ),
              image: AssetImage('assets/imgs/pictures/ready_to_play.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(top: 10.0, bottom: 100.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                  child: Text("Ready to Play?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
                  child: Text(
                      "Are you ready to become a professional guitar player?",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 30.0, right: 10),
                  child: SizedBox(
                    child: RaisedButton(
                        onPressed: () async {
                          // bool status1 = await App.getAllCourses();
                          // bool status2 = await App.studyingCourses();
                          // bool status3 = await App.quicklessons();
                          // bool status4 = await App.freelesson();
                          // print(status1);
                          // print(status2);
                          // print(status3);
                          // print(status4);
                          Navigator.pushNamed(context, "/start_loading");
                        },
                        color: Color.fromRGBO(107, 43, 20, 1.0),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                        child: Text("Start now",
                            style: TextStyle(fontSize: 16.0))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
