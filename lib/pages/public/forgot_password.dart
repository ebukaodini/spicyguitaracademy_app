import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  ForgotPasswordPageState createState() => new ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // properties
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            'Forget Password',
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
                  TextField(
                    controller: _email,
                    autofocus: true,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      forgotPassword();
                    },
                    style: TextStyle(fontSize: 20.0, color: brown),
                    decoration: InputDecoration(
                        labelText: "Email Address",
                        hintText: "yourname@domain.com"),
                  ),

                  SizedBox(height: 40.0),

                  Container(
                    width: MediaQuery.of(context).copyWith().size.width,
                    child: RaisedButton(
                      onPressed: () {
                        forgotPassword();
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          side: BorderSide(color: brown)),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Submit", style: TextStyle(fontSize: 20.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),
                ]))));
  }

  void forgotPassword() async {
    try {
      loading(context);

      var resp = await request('/api/forgotpassword',
          method: 'POST', body: {'email': _email.text});

      Navigator.pop(context);
      if (resp['status'] == true) {
        // success(context, resp['message']);
        Student.forgotPassword = true;
        Navigator.popAndPushNamed(context, "/verify",
            arguments: {'email': _email.text});
      } else {
        throw Exception(resp['message']);
      }
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e), title: 'Request failed');
    }
  }
}
