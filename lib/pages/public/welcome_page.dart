import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(107, 43, 20, 0.5),
      body:
      Stack(
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  // Colors.accents,
                  Colors.black.withOpacity(0.6), 
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(1.0) 
                ],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.srcOver,
            child: Container (
              decoration: BoxDecoration(
                // color: Color.fromRGBO(107, 43, 20, 1.0),
                image: DecorationImage(
                  image: AssetImage('assets/imgs/pictures/welcome_picture.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment(-0.5, 6.0),
                ),
              ),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 10.0, bottom: 100.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Text(
                    "Hi, Welcome to Spicy Guitar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    )
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
                  child: Text(
                    "Academy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    )
                  ),
                ),
                
                Container(
                  margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: RaisedButton(
                    onPressed: () {Navigator.pushNamed(context, "/login_page");},
                    color: Colors.transparent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.white)
                    ),
                    padding: EdgeInsets.fromLTRB(140, 10, 140, 10),
                    child: Text("Login",style: TextStyle( fontSize: 20.0 )),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: RaisedButton(
                    onPressed: () {Navigator.pushNamed(context, "/register_page");},
                    color: Color.fromRGBO(107, 43, 20, 1.0),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      // side: BorderSide(color: Colors.white)
                    ),
                    padding: EdgeInsets.fromLTRB(135, 10, 135, 10),
                    child: Text("Signup",style: TextStyle( fontSize: 20.0 )),
                  ),
                )

              ],
            ),
          )
        ]
      )
    );
    
  }

}       