import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';
// import 'package:spicyguitaracademy/common.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool authenticated = false;

// --------------------------------
  // AppUpdateInfo _updateInfo;

  bool _flexibleUpdateAvailable = false;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.startFlexibleUpdate().then((_) {
          setState(() {
            _flexibleUpdateAvailable = true;
          });
        }).catchError((e) {
          snackbar(context, stripExceptions(e.toString()));
        });
      }
    }).catchError((e) {
      snackbar(context, e.toString());
    });
  }

// --------------------------------

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      checkForUpdate();
    }
    checkAuthentication();
    getPaymentKey();
  }

  checkAuthentication() async {
    try {
      await Student.pseudoSignin();
      this.setState(() {
        authenticated = Auth.authenticated;
      });
    } catch (e) {
      error(context, stripExceptions(e));
    }
  }

  getPaymentKey() async {
    try {
      dynamic resp = await request('/api/paystack/key');
      if (resp['status'] == true) {
        paystackPublicKey = resp['data']['key'];
        print(paystackPublicKey);
      }
    } catch (e) {
      print(e);
    }
  }

  logout() {
    Student.signout();
    this.setState(() {
      authenticated = Auth.authenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(107, 43, 20, 0.5),
        body: Stack(children: <Widget>[
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
            child: Container(
              decoration: BoxDecoration(
                // color: brown,
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
                    child: Text("Hi, Welcome to Spicy Guitar Academy",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0))),
                authenticated == false
                    ? Column(
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).copyWith().size.width -
                                    30.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              color: Colors.transparent,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.white)),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("Login",
                                  style: TextStyle(fontSize: 20.0)),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width:
                                MediaQuery.of(context).copyWith().size.width -
                                    30.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/register");
                              },
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.white)),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("Signup",
                                  style: TextStyle(fontSize: 20.0)),
                            ),
                          ),
                        ],
                      )
                    : Column(children: [
                        Container(
                          width: MediaQuery.of(context).copyWith().size.width -
                              30.0,
                          child: RaisedButton(
                            onPressed: () async {
                              try {
                                loading(context);
                                await Student.pseudoSignin(handleClick: true);
                                Navigator.pop(context);
                                if (Student.status != 'active') {
                                  Navigator.pushNamed(context, "/verify");
                                } else {
                                  Navigator.pushNamed(context, "/welcome_note");
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                error(context, stripExceptions(e));
                              }
                            },
                            color: Colors.transparent,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white)),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                "Continue as ${Student.firstname ?? 'Guest'}",
                                style: TextStyle(fontSize: 20.0)),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).copyWith().size.width -
                              30.0,
                          child: RaisedButton(
                            onPressed: () {
                              logout();
                              // Navigator.pushNamed(context, "/dashboard");
                            },
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white)),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text("Logout",
                                style: TextStyle(fontSize: 20.0)),
                          ),
                        )
                      ])
              ],
            ),
          )
        ]));
  }
}
