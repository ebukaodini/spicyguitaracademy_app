// import 'package:Spicy_Guitar_Academy/services/common.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/app.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _cpass = TextEditingController();

  // properties
  bool _agreedTCPP = false;
  bool _obscurePwd = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        // extendBody: true,
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
                  Navigator.pop(context);
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
                  margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Text("Create",
                      style: TextStyle(
                          color: Color.fromRGBO(107, 43, 20, 1.0),
                          fontSize: 35.0)),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 0.0, bottom: 20.0),
                  child: Text("Account",
                      style: TextStyle(
                          color: Color.fromRGBO(107, 43, 20, 1.0),
                          fontSize: 35.0)),
                ),

                // Firstname field
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _fname,
                    cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                    autofocus: true,
                    style: TextStyle(
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                        fontSize: 20.0),
                    decoration: InputDecoration(
                      labelText: "First Name",
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                // Lastname field
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _lname,
                    cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                    autofocus: true,
                    style: TextStyle(
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                        fontSize: 20.0),
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                // Email field
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _email,
                    cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                    style: TextStyle(
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                        fontSize: 20.0),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                // Telephone field
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _tel,
                    cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                    style: TextStyle(
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                        fontSize: 20.0),
                    decoration: InputDecoration(
                      labelText: "Telephone",
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                // Password field
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _pass,
                    cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                    obscureText: _obscurePwd,
                    style: TextStyle(
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                        fontSize: 20.0),
                    decoration: InputDecoration(
                      suffix: FlatButton(
                        onPressed: () => setState(() {
                          _obscurePwd = !_obscurePwd;
                        }),
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        child: new Icon(Icons.remove_red_eye,
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                // Confirm Password field
                Container(
                  margin: const EdgeInsets.only(bottom: 50.0),
                  child: TextField(
                    controller: _cpass,
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
                        // color: Color.fromRGBO(107, 43, 20, 1.0),
                        child: new Icon(Icons.remove_red_eye,
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1.0),
                          fontSize: 20.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(107, 43, 20, 1.0)),
                      ),
                    ),
                  ),
                ),

                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        onChanged: (value) => setState(() {
                          _agreedTCPP = !_agreedTCPP;
                        }),
                        checkColor: Colors.white,
                        activeColor: Color.fromRGBO(107, 43, 20, 1.0),
                        value: _agreedTCPP,
                      ),
                      FlatButton(
                          onPressed: () {
                            //{Navigator.pushNamed(context, "/forgotpassword_page");},
                            // refirect to the terms and confitions page
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("I have carfully read and agreed to the",
                                  style: TextStyle(
                                      color: Color.fromRGBO(112, 112, 112, 1.0),
                                      fontSize: 16.0)),
                              Text("Terms and Privacy Policy",
                                  style: TextStyle(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      fontSize: 16.0)),
                            ],
                          ))
                    ]),

                SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30.0),
                      child: RaisedButton(
                          onPressed: () async {
                            if (_agreedTCPP == true) {
                              // submit
                              loading(context);
                              var resp = await request('GET', register, body: {
                                'firstname': _fname.text,
                                'lastname': _lname.text,
                                'email': _email.text,
                                'telephone': _tel.text,
                                'password': _pass.text,
                                'cpassword': _cpass.text
                              });
                              Navigator.pop(context);
                              if (resp['status'] == true) {
                                Navigator.pushNamed(context, "/login_page");
                              } else {
                                // TODO: handle error messages
                                // if (resp['data'] != null) {
                                //   String msg = resp['data'].toList();
                                // }
                                error(context, resp['message']);
                              }
                            } else {
                              error(context,
                                  'Please agree to Terms and Condition.');
                            }
                          },
                          color: Color.fromRGBO(107, 43, 20, 1.0),
                          textColor: Colors.white,
                          autofocus: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.fromLTRB(130, 15, 130, 15),
                          child: Text("Signup",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.normal))),
                    )),
              ],
            ),
          ])),
        ));
  }
}
