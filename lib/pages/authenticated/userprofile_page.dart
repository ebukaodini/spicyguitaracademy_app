import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:core';
import 'dart:io';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:'

class UserProfilePage extends StatefulWidget {
  UserProfilePage();

  @override
  UserProfilePageState createState() => new UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  UserProfilePageState();
  File file;

  @override
  void initState() {
    super.initState();
  }

  void selectImage() async {
    // // try {
    //   FilePickerResult result =
    //     await FilePicker.platform.pickFiles(type: FileType.image);
    //   // allowedExtensions: ["jpg", "png"]
    //   if (result != null) {
    //     file = File(result.files.single.path);
    //   }

    //   loading(context, message: 'Uploading');

    //   var resp = await upload('/api/student/avatar/update', 'avatar', file,
    //       method: 'POST');

    //   Navigator.pop(context);

    //   if (resp['status'] == true) {
    //     success(context, resp['message']);
    //     setState(() {});
    //   } else {
    //     error(context, resp['message']);
    //   }
    // // } catch (e) {
    // //   Navigator.pop(context);
    // //   error(context, e.toString());
    // // }

    
    try {
      FilePickerResult result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        file = File(result.files.single.path);
      }
    } catch (e) {
      error(context, "Image picker error " + e.toString());
    }

    loading(context, message: 'Uploading');

    var resp = await upload('/api/student/avatar/update', 'avatar', file,
        method: 'POST',
        headers: {
          'JWToken': Auth.token,
          'cache-control': 'max-age=0, must-revalidate'
        });

    Navigator.pop(context);

    if (resp['status'] == true) {
      setState(() => Student.avatar = resp['data']['path']);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        SizedBox(height: 5),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: brown,
              backgroundImage: NetworkImage('$baseUrl/${Student.avatar}',
                  headers: {'cache-control': 'max-age=0, must-revalidate'}),
            ),
            IconButton(
                splashRadius: 30,
                icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: brown,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Icon(
                      Icons.edit,
                      color: grey,
                    )),
                onPressed: () {
                  selectImage();
                })
          ],
        ),

        Text("${Student.firstname} ${Student.lastname}",
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 18.0, color: darkgrey)),
        Container(
            padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: brown),
            child: Text(
              "${Student.takenCourses} of ${Student.allCourses}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )),
        Text("${Student.takenLessons} of ${Student.allLessons} lessons"),
        SizedBox(height: 50),

        // Button Selections
        Container(
          width: screen(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: <Widget>[
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 150.0,
                    child: MaterialButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      onPressed: () {
                        Navigator.pushNamed(context, '/choose_category');
                      },
                      color: Colors.white,
                      textColor: brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/imgs/icons/category_icon.svg",
                            matchTextDirection: true,
                          ),
                          Text("Category",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 150.0,
                    height: 150.0,
                    child: MaterialButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                      onPressed: () {
                        Navigator.pushNamed(context, '/choose_plan');
                        //arguments: {'selectedplan': Student.plan}
                      },
                      color: Colors.white,
                      textColor: brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/imgs/icons/subscription_icon.svg",
                            matchTextDirection: true,
                          ),
                          Text("Subscription",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(height: 15),
              Container(
                  width: screen(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        height: 150.0,
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          onPressed: () {
                            Navigator.pushNamed(context, "/invite_friend");
                          },
                          color: Colors.white,
                          textColor: brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/imgs/icons/invite_friend_icon.svg",
                                matchTextDirection: true,
                              ),
                              Text("Invite a friend",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        height: 150.0,
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          onPressed: () {
                            Navigator.pushNamed(context, '/help');
                          },
                          color: Colors.white,
                          textColor: brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/imgs/icons/help_circle_icon.svg",
                                matchTextDirection: true,
                              ),
                              Text("Help",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),

        // Make-do spacer
        Container(
          margin: EdgeInsets.only(bottom: 30),
        ),
      ])),
    );
  }
}
