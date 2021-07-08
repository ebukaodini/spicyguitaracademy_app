import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // properties
  bool _obscurePwd = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    _email.text = Student.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: brown),
          backgroundColor: grey,
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(
                color: brown,
                fontSize: 30,
                fontFamily: "Poppins",
                fontWeight: FontWeight.normal),
          ),
          elevation: 0,
        ),
        body: SafeArea(
            minimum: EdgeInsets.all(5.0),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  SizedBox(height: 40.0),

                  // Email field
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 20.0, color: brown),
                    decoration: InputDecoration(
                        labelText: "Email Address",
                        hintText: "yourname@domain.com"),
                  ),

                  SizedBox(height: 20.0),

                  // Password field
                  TextFormField(
                      controller: _pass,
                      obscureText: _obscurePwd,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: [AutofillHints.password],
                      // onSubmitted: (value) {
                      //   login();
                      // },
                      style: TextStyle(fontSize: 20.0, color: brown),
                      decoration: InputDecoration(
                          labelText: "Password",
                          suffix: IconButton(
                              onPressed: () => setState(() {
                                    _obscurePwd = !_obscurePwd;
                                  }),
                              icon: Icon(_obscurePwd == true
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined)))),

                  SizedBox(height: 40.0),

                  Container(
                    width: MediaQuery.of(context).copyWith().size.width,
                    child: RaisedButton(
                      onPressed: () {
                        login();
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          side: BorderSide(color: brown)),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Login", style: TextStyle(fontSize: 20.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  Row(
                    // alignment: Alignment.centerLeft,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Create Account',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: brown),
                          )),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgot_password');
                          },
                          child: Text(
                            'Forgot Password',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: brown),
                          ))
                    ],
                  )
                ]))));
  }

  void login() async {
    try {
      loading(context);

      var resp = await request('/api/login',
          method: 'POST', body: {'email': _email.text, 'password': _pass.text});

      if (resp['status'] == true) {
        var data = resp['data'];
        await Student.signin(data['student'], data['token']);
        _pass.text = "";

        Navigator.pop(context);
        if (Student.status != 'active') {
          Navigator.pushNamed(context, "/verify");
        } else {
          if (reAuthentication == true) {
            reAuthentication = false;
            Navigator.pop(context);
          } else {
            Navigator.pushNamed(context, "/welcome_note");
          }
        }
      } else {
        throw Exception(resp['message']);
      }
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e), title: 'Login failed');
    }
  }
}
