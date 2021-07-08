// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => new EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _tel = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fname.text = Student.firstname;
    _lname.text = Student.lastname;
    _tel.text = Student.telephone;
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
            'Edit Profile',
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

              // Firstname field
              TextField(
                controller: _fname,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 20.0, color: brown),
                decoration: InputDecoration(
                  labelText: "First Name",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // Lastname field
              TextField(
                controller: _lname,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 20.0, color: brown),
                decoration: InputDecoration(
                  labelText: "Last Name",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              // Telephone field
              TextField(
                controller: _tel,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 20.0, color: brown),
                decoration:
                    InputDecoration(labelText: "Telephone", hintText: "+234"),
              ),
              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).copyWith().size.width,
                child: RaisedButton(
                  onPressed: () {
                    register();
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

  void register() async {
    try {
      loading(context);

      var resp = await request('/api/account/updateprofile',
          method: 'POST',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          },
          body: {
            'firstname': _fname.text,
            'lastname': _lname.text,
            'telephone': _tel.text
          });

      if (resp['status'] == true) {
        Navigator.pop(context);
        Student.firstname = _fname.text;
        Student.lastname = _lname.text;
        Student.telephone = _tel.text;

        // cache updates
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        prefs.setString('firstname', _fname.text);
        prefs.setString('lastname', _lname.text);
        prefs.setString('telephone', _tel.text);

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
      error(context, stripExceptions(e), title: "Profile update failed");
    }
  }
}
