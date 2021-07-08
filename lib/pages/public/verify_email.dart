import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class VerifyPage extends StatefulWidget {
  @override
  VerifyPageState createState() => new VerifyPageState();
}

class VerifyPageState extends State<VerifyPage> {
  // properties
  TextEditingController _token = TextEditingController();
  String _email = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Student.forgotPassword) {
      final Map args = ModalRoute.of(context).settings.arguments as Map;
      _email = args['email'];
    }
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: brown),
          backgroundColor: grey,
          centerTitle: true,
          title: Text(
            'Verify Email',
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
                    controller: _token,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 20.0, color: brown),
                    decoration: InputDecoration(
                        labelText: "Authentication Token", hintText: "******"),
                  ),

                  SizedBox(height: 40.0),

                  Container(
                    width: MediaQuery.of(context).copyWith().size.width,
                    child: RaisedButton(
                      onPressed: () {
                        verify();
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          side: BorderSide(color: brown)),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("Verify", style: TextStyle(fontSize: 20.0)),
                    ),
                  ),
                ]))));
  }

  void verify() async {
    try {
      loading(context, message: 'Verifying');

      // print("${_token.text} ${_email}");
      var resp = await request('/api/verify', method: 'POST', body: {
        'token': _token.text,
        'email': Student.isNewStudent == true ? Student.email : _email
      });

      // error(context, resp['status']);
      if (resp['status'] == true) {
        Student.status = 'active';

        Navigator.pop(context);
        if (Student.forgotPassword == true) {
          Navigator.popAndPushNamed(context, "/resetpassword",
              arguments: {'email': _email});
        } else if (Student.isNewStudent == true) {
          Navigator.popAndPushNamed(context, "/login");
        } else {
          Navigator.popAndPushNamed(context, "/welcome_note");
        }
      } else {
        Map<String, dynamic> data = {};
        String msg = "";
        if (resp['data'] != null) {
          data = resp['data'];
          int count = 1;
          data.forEach((key, value) {
            msg += "$count. $value\n";
            count++;
          });
        } else {
          msg = resp['message'];
        }
        throw Exception("$msg");
      }
    } catch (e) {
      Navigator.pop(context);
      error(context, stripExceptions(e), title: 'Verification failed');
    }
  }
}
