import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // properties
  bool _obscurePwd = true;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: SafeArea(
          minimum: EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20, left: 2, bottom: 50),
              child: MaterialButton(
                minWidth: 20,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/welcome_page");
                },
                child: new Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(107, 43, 20, 1.0),
                  size: 20.0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.white)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 0.0, bottom: 20.0),
                  child: Text("Login",
                      style: TextStyle(
                          color: Color.fromRGBO(107, 43, 20, 1.0),
                          fontSize: 35.0)),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 60.0),
                  child: Text("Email",
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0)),
                ),

                // Email field
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _email,
                    cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                    autofocus: true,
                    style: TextStyle(
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                        fontSize: 20.0),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: Text("Password",
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0)),
                ),

                // Password field
                Container(
                  margin: const EdgeInsets.only(bottom: 50.0),
                  child: TextField(
                    controller: _pass,
                    cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                    obscureText: _obscurePwd,
                    style: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                        fontSize: 20.0),
                    decoration: InputDecoration(
                      suffix: FlatButton(
                        onPressed: () => setState(() {
                          _obscurePwd = !_obscurePwd;
                        }),
                        child: new Icon(Icons.remove_red_eye,
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        onPressed: () async {
                          loading(context);
                          var resp = await request('POST', login, body: {
                            'email': _email.text,
                            'password': _pass.text
                          });
                          Navigator.pop(context);
                          if (resp == false)
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login_page', (route) => false);
                          Map<String, dynamic> json = resp;
                          if (json['success'] != '') {
                            User.reset();
                            User.id = json['student']['id'];
                            User.firstname = json['student']['firstname'];
                            User.lastname = json['student']['lastname'];
                            User.email = json['student']['email'];
                            User.telephone = json['student']['telephone'];
                            User.avatar = json['student']['avatar'];
                            User.token = json['token'];
                            User.justLoggedIn = true;

                            // if (User.wasLoggedIn == true) {
                            //   Navigator.pushNamed(context, "/ready_to_play");
                            // } else {
                            User.wasLoggedIn = true;
                            Navigator.pushNamed(context, "/welcome_note");
                            // }
                          } else {
                            error(context, json['errors']);
                          }
                          
                        },
                        color: Color.fromRGBO(107, 43, 20, 1.0),
                        textColor: Colors.white,
                        // focusColor: Color.fromRGBO(107, 43, 20, 1.0),
                        autofocus: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          // side: BorderSide(color: Colors.white)
                        ),
                        // width: 100,
                        padding: EdgeInsets.fromLTRB(130, 15, 130, 15),
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: 20.0, fontStyle: FontStyle.normal))),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  // margin: const EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                    onPressed:
                        () {}, //{Navigator.pushNamed(context, "/forgotpassword_page");},
                    child: Text("forgot password?",
                        style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1.0),
                            fontSize: 16.0)),
                  ),
                ),
              ],
            ),
          ])),
        ));
  }
}
