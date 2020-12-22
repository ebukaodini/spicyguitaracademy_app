import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/app.dart';
// import '../../services/common.dart';

class InviteFriend extends StatefulWidget {
  @override
  InviteFriendState createState() => new InviteFriendState();
}

class InviteFriendState extends State<InviteFriend> {
  // properties
  // static const _remaining_days = 0;
  // String _selectedPlan = "1Y";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _inviteController = TextEditingController();
    final _scaffoldKey = new GlobalKey<ScaffoldState>();

    bool isLoading = false;

    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: OrientationBuilder(builder: (context, orientation) {
          return SafeArea(
              minimum: EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                // back button
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 20, left: 2, bottom: 10),
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

                Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Spicy text
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text(
                              "Spicy Guitar Academy",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          // Message text
                          Container(
                            child: Text(
                              "Enter the email address of your friend and we'll send him/her an invitation email.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // color: Color.fromRGBO(107, 43, 20, 1.0),
                                  color: Color.fromRGBO(112, 112, 112, 1.0),
                                  fontSize: 18),
                            ),
                          ),

                          // text box for entering emails adresses
                          Container(
                            margin: const EdgeInsets.only(top: 35, bottom: 20),
                            width: MediaQuery.of(context).copyWith().size.width,
                            child: TextField(
                              controller: _inviteController,
                              cursorColor: Color.fromRGBO(107, 43, 20, 1.0),
                              autofocus: true,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  fontSize: 20.0,
                                  height: 1.6),
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1.0),
                                    fontSize: 20.0),
                                focusColor: Color.fromRGBO(107, 43, 20, 1.0),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                border: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Color.fromRGBO(
                                            112, 112, 112, 1.0))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Color.fromRGBO(
                                            112, 112, 112, 1.0))),
                              ),
                            ),
                          ),

                          // invite btn
                          Container(
                            alignment: Alignment.centerRight,
                            height: 100,
                            margin:
                                EdgeInsets.only(top: 20, left: 2, bottom: 10),
                            child: MaterialButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              onPressed: () async {
                                // setState(() => isLoading = true);
                                loading(context);
                                Map<String, dynamic> resp = await request(
                                    'POST', invite,
                                    body: {'friend': _inviteController.text});
                                Navigator.pop(context);
                                // setState(() => isLoading = false);
                                if (resp['status'] == false) {
                                  error(context, resp['message']);
                                } else {
                                  success(context, resp['message']);
                                }
                              },
                              color: Colors.white,
                              textColor: Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
              ])));
        }));
  }
}
