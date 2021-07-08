import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class InviteFriend extends StatefulWidget {
  @override
  InviteFriendState createState() => new InviteFriendState();
}

class InviteFriendState extends State<InviteFriend> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: brown),
          backgroundColor: grey,
          centerTitle: true,
          title: Text(
            'Invite a friend',
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
                child: Column(children: <Widget>[
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                    // Spicy text
                    SizedBox(height: 30),
                    Text(
                      "Spicy Guitar Academy",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: brown,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 30),
                    // Message text
                    Container(
                      child: Text(
                        "Enter the email address of your friend and we'll send him/her an invitation email.",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: darkgrey, fontSize: 18),
                      ),
                    ),

                    SizedBox(height: 30),

                    // text box for entering emails adresses
                    TextField(
                        controller: _email,
                        // autocorrect: true,
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        // onSubmitted: (value) => _searchCourses(value),
                        style: TextStyle(fontSize: 20.0, color: brown),
                        decoration: InputDecoration(
                          hintText: "Email Address",
                        )),

                    // invite btn
                    Container(
                      alignment: Alignment.centerRight,
                      height: 100,
                      margin: EdgeInsets.only(top: 20, left: 2, bottom: 10),
                      child: MaterialButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        onPressed: () async {
                          try {
                            loading(context, message: 'Sending');
                            var resp = await request(
                                '/api/student/invite-a-friend',
                                method: 'POST',
                                headers: {
                                  'JWToken': Auth.token,
                                  'cache-control': 'max-age=0, must-revalidate'
                                },
                                body: {
                                  'friend': _email.text
                                });
                            Navigator.pop(context);
                            if (resp['status'] == false) {
                              error(context, resp['message']);
                            } else {
                              _email.clear();
                              success(context, resp['message']);
                            }
                          } on AuthException catch (e) {
                            error(context, stripExceptions(e));
                            reAuthenticate(context);
                          } catch (e) {
                            error(context, stripExceptions(e));
                          }
                        },
                        color: Colors.white,
                        textColor: brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/imgs/icons/invite_friend_icon.svg",
                              matchTextDirection: true,
                            ),
                            Text("invite friend",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ]))
            ]))));
  }
}
