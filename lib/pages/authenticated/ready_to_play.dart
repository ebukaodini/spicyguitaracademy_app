import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';

class ReadyToPlayTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: darkbrown,
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
                    Text("Ready to Play?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(height: 10),
                    Text(
                        "Are you ready to become a professional guitar player?",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    SizedBox(height: 50.0),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        child: RaisedButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, "/start_loading");
                            },
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 18),
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
