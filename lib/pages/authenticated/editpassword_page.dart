// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class EditPasswordPage extends StatefulWidget {
  @override
  EditPasswordPageState createState() => new EditPasswordPageState();
}

class EditPasswordPageState extends State<EditPasswordPage> {
  TextEditingController _opass = TextEditingController();
  TextEditingController _npass = TextEditingController();
  TextEditingController _cpass = TextEditingController();

  // properties
  bool _obscureOPwd = true;
  bool _obscureNPwd = true;
  bool _obscureCPwd = true;

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
            'Edit Password',
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

              // Password field
              TextField(
                  controller: _opass,
                  obscureText: _obscureOPwd,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 20.0, color: brown),
                  decoration: InputDecoration(
                      labelText: "Old Password",
                      suffix: IconButton(
                          onPressed: () => setState(() {
                                _obscureOPwd = !_obscureOPwd;
                              }),
                          icon: Icon(_obscureOPwd == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined)))),
              SizedBox(height: 20.0),
              // Password field
              TextField(
                  controller: _npass,
                  obscureText: _obscureNPwd,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 20.0, color: brown),
                  decoration: InputDecoration(
                      labelText: "New Password",
                      suffix: IconButton(
                          onPressed: () => setState(() {
                                _obscureNPwd = !_obscureNPwd;
                              }),
                          icon: Icon(_obscureNPwd == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined)))),
              SizedBox(height: 20.0),
              TextField(
                  controller: _cpass,
                  obscureText: _obscureCPwd,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 20.0, color: brown),
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      suffix: IconButton(
                          onPressed: () => setState(() {
                                _obscureCPwd = !_obscureCPwd;
                              }),
                          icon: Icon(_obscureCPwd == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined)))),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Password must contain letters, numbers and must be atleast 8 characters.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).copyWith().size.width,
                child: RaisedButton(
                  onPressed: () {
                    updatepassword();
                  },
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      side: BorderSide(color: brown)),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Update", style: TextStyle(fontSize: 20.0)),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          )),
        ));
  }

  void updatepassword() async {
    try {
      loading(context);

      var resp = await request('/api/account/updatepassword',
          method: 'POST',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          },
          body: {
            'opassword': _opass.text,
            'npassword': _npass.text,
            'cpassword': _cpass.text
          });

      if (resp['status'] == true) {
        Navigator.pop(context);
        success(context, resp['message']);
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
      error(context, stripExceptions(e), title: "Update password failed");
    }
  }
}
