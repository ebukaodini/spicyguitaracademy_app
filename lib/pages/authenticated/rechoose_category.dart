import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class ReChooseCategory extends StatefulWidget {
  @override
  ReChooseCategoryState createState() => new ReChooseCategoryState();
}

class ReChooseCategoryState extends State<ReChooseCategory> {
  @override
  void initState() {
    super.initState();
  }
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // internal properties
    int _completedCourses = User.categoryStats['takenCourses'];
    int _totalCourses = User.categoryStats['allCourses'];
    int _selectedCategory = User.category ?? 0;
    // String _selectedCategory;

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

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // title text
                  Container(
                    child: Text("Choose a \nCategory",
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(107, 43, 20, 1.0),
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600)),
                  ),

                  // message test
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: 300,
                    child: Text(
                      // _completedCourses == _totalCourses ?  : "You have not completed all courses in this category." ,
                      "You have completed $_completedCourses out $_totalCourses courses in this category!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(
                              112, 112, 112, 1.0), //(107, 43, 20, 1.0),
                          fontSize: 20.0),
                    ),
                  ),

                  // category blocks
                  Container(
                      margin: const EdgeInsets.only(top: 60.0),
                      child: Row(
                        mainAxisAlignment: orientation == Orientation.portrait
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: orientation == Orientation.portrait
                                    ? 0.0
                                    : 20.0),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              onPressed: () {
                                if (_completedCourses == _totalCourses)
                                  setState(() => _selectedCategory = 1);
                              },
                              color: _selectedCategory == 1
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == 1
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                child: Text("Beginner",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: orientation == Orientation.portrait
                                    ? 0.0
                                    : 20.0),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              onPressed: () {
                                if (_completedCourses == _totalCourses)
                                  setState(() => _selectedCategory = 2);
                              },
                              color: _selectedCategory == 2
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == 2
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                child: Text("Amateur",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          )
                        ],
                      )),

                  Container(
                      margin: EdgeInsets.only(
                        top: orientation == Orientation.portrait ? 20.0 : 40.0,
                      ),
                      child: Row(
                        mainAxisAlignment: orientation == Orientation.portrait
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: orientation == Orientation.portrait
                                    ? 0.0
                                    : 20.0),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              onPressed: () {
                                if (_completedCourses == _totalCourses)
                                  setState(() => _selectedCategory = 3);
                              },
                              color: _selectedCategory == 3
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == 3
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                child: Text("Intermediate",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: orientation == Orientation.portrait
                                    ? 0.0
                                    : 20.0),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 25),
                              onPressed: () {
                                if (_completedCourses == _totalCourses)
                                  setState(() => _selectedCategory = 4);
                              },
                              color: _selectedCategory == 4
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == 4
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                child: Text("Advanced",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          )
                        ],
                      )),

                  // confirm btn
                  Container(
                    margin: const EdgeInsets.only(top: 100.0, bottom: 30.0),
                    width: 310,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      onPressed: (_selectedCategory == User.category || _selectedCategory == 0)
                          ? null
                          : () async {
                              // Navigator.pushNamed(context, "/ready_to_play");
                              // go back and select another category
                              String category = _selectedCategory.toString();
                              
                              
                              loading(context);
                              var resp = await request('POST', chooseCategory,
                                  body: {'category': category});
                              // Map<String, dynamic> json = resp;
                              if (resp['status'] == false) {
                                Navigator.pop(context);
                                message(context, resp['message']);
                              } else {
                                // get the current category and stats
                                var resp = await request('GET', studentStats);
                                if (resp == false)
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login_page', (route) => false);
                                // Map<String, dynamic> json = resp;
                                // if (resp['status'] == false) {
                                //   User.categoryStats = null;
                                //   User.category = null;
                                // } else {
                                  User.categoryStats = resp['data'];
                                  User.category = resp['data']['category'];
                                // }
                                Navigator.pop(context);
                                if (User.category == null) {
                                  message(context, 'Please Try Again');
                                  Navigator.popAndPushNamed(
                                      context, "/choose_category");
                                  // App.showMessage(_scaffoldKey, "Please Try Again.");
                                } else {
                                  Navigator.popAndPushNamed(
                                      context, "/ready_to_play");
                                }
                              }

                            },
                      color: _selectedCategory == 0
                          ? Colors.white
                          : Color.fromRGBO(107, 43, 20, 1.0),
                      disabledColor: Colors.white,
                      disabledTextColor: Color.fromRGBO(107, 43, 20, 1.0),
                      textColor: _selectedCategory == 0
                          ? Color.fromRGBO(107, 43, 20, 1.0)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: Color.fromRGBO(107, 43, 20, 1.0),
                              width: 2.0)),
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Text("Done", style: TextStyle(fontSize: 20.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ])),
          );
        }));
  }
}
