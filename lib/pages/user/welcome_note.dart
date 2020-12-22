import 'package:flutter/material.dart';
import '../../services/app.dart';

class WelcomeNotePage extends StatefulWidget {
  @override
  WelcomeNotePageState createState() => new WelcomeNotePageState();
}

class WelcomeNotePageState extends State<WelcomeNotePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  // properties
  String _firstname = "Welcome";

  @override
  void initState() {
    super.initState();

    // get the user's firstname
    _firstname = User.firstname;
  }

  _loadSubscriptionPlans() async {
    var resp = await request('GET', subscriptionPlan);
    if (resp == false)
      Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (route) => false);
    Map<String, dynamic> json = resp;
    Subscription.plans = json['plans'];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: OrientationBuilder(builder: (context, orientation) {
          return SafeArea(
              minimum: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 80),
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).copyWith().size.height
                      : 600,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45)),
                    color: Colors.white,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 70.0),
                          child: Text(
                            "Hi, " + _firstname,
                            style: TextStyle(
                              color: Color.fromRGBO(107, 43, 20, 1.0),
                              fontSize: 40.0,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            "You are welcome to Spicy Guitar Academy.",
                            style: TextStyle(
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                fontSize: 25.0,
                                // fontWeight: FontWeight.bold,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            "Spicy Guitar Academy is aimed at guiding beginners to fulfill their dreams of becoming professional guitar players.",
                            style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 1.0),
                              fontSize: 20.0,
                              // fontWeight: FontWeight.bold,
                            ),
                            strutStyle: StrutStyle(
                              fontSize: 20.0,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            "We have the best qualified tutors who are dedicated to help you develop from start to finish to make your dreams come true.",
                            style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 1.0),
                              fontSize: 20.0,
                              // fontWeight: FontWeight.bold,
                            ),
                            strutStyle: StrutStyle(
                              fontSize: 20.0,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 60.0),
                          child: SizedBox(
                            child: RaisedButton(
                                onPressed: () async {
                                  {
                                    // get subscription status
                                    var resp = await request(
                                        'GET', subscriptionStatus);
                                    if (resp == false) {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/login_page', (route) => false);
                                    } else {
                                      Map<String, dynamic> json = resp;
                                      User.subStatus = json['status'];
                                      User.daysRemaining = json['days'];
                                      User.plan = json['plan'] ?? '0';
                                    }
                                    print(User.subStatus);
                                    print(User.daysRemaining);
                                  }
                                  {
                                    // get the current category and stats
                                    var resp =
                                        await request('GET', studentStats);
                                    // print('STUDENT STATS => ' + resp);
                                    if (resp == false)
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/login_page', (route) => false);
                                    Map<String, dynamic> json = resp;
                                    if (json['status'] == false) {
                                      User.categoryStats = null;
                                      User.category = null;
                                    } else {
                                      User.categoryStats = json['stats'];
                                      User.category = json['category'];
                                    }
                                  }
                                  
                                  await _loadSubscriptionPlans();
                                  if (User.subStatus == "ACTIVE") {
                                    if (User.category == null) {
                                      Navigator.popAndPushNamed(
                                          context, "/choose_category");
                                    } else {
                                      Navigator.popAndPushNamed(
                                          context, "/ready_to_play");
                                    }
                                  } else if (User.subStatus == "INACTIVE") {
                                    
                                    Navigator.popAndPushNamed(
                                        context, "/choose_plan");
                                  }
                                },
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text("continue",
                                    style: TextStyle(fontSize: 20.0))),
                          ),
                        ),
                      ]),
                ),
              ));
        }));
  }
}
