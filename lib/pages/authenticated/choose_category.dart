import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class ChooseCategory extends StatefulWidget {
  @override
  ChooseCategoryState createState() => new ChooseCategoryState();
}

class ChooseCategoryState extends State<ChooseCategory> {
  // properties
  String _selectedCategory = "";
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _titleOrient(orientation) {
      if (orientation == Orientation.landscape) {
        return Container(
          child: Text(
            "Choose a Category",
            textWidthBasis: TextWidthBasis.longestLine,
            style: TextStyle(
                color: Color.fromRGBO(107, 43, 20, 1.0),
                fontSize: 35.0,
                fontWeight: FontWeight.w600),
            strutStyle: StrutStyle(
              fontSize: 35.0,
              height: 1.8,
            ),
          ),
        );
      } else {
        return Column(children: <Widget>[
          Container(
            child: Text("Choose a",
                style: TextStyle(
                    color: Color.fromRGBO(107, 43, 20, 1.0),
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text("Category",
                style: TextStyle(
                    color: Color.fromRGBO(107, 43, 20, 1.0),
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600)),
          ),
        ]);
      }
    }

    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
        body: OrientationBuilder(builder: (context, orientation) {
          return SafeArea(
            minimum: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 20, left: 2, bottom: 10),
                child: MaterialButton(
                  minWidth: 20,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  // onPressed: (){ Navigator.popAndPushNamed(context, "/welcome_note");},
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
                  _titleOrient(orientation),
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
                              onPressed: () => setState(
                                  () => _selectedCategory = "Beginner"),
                              color: _selectedCategory == "Beginner"
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == "Beginner"
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
                              onPressed: () =>
                                  setState(() => _selectedCategory = "Amateur"),
                              color: _selectedCategory == "Amateur"
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == "Amateur"
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
                              onPressed: () => setState(
                                  () => _selectedCategory = "Intermediate"),
                              color: _selectedCategory == "Intermediate"
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == "Intermediate"
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
                              onPressed: () => setState(
                                  () => _selectedCategory = "Advanced"),
                              color: _selectedCategory == "Advanced"
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedCategory == "Advanced"
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
                  Container(
                    margin: const EdgeInsets.only(top: 100.0, bottom: 30.0),
                    width: 310,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      onPressed: _selectedCategory == ""
                          ? null
                          : () async {
                              String category = '0';
                              switch (_selectedCategory) {
                                case "Beginner":
                                  category = '1';
                                  break;
                                case "Amateur":
                                  category = '2';
                                  break;
                                case "Intermediate":
                                  category = '3';
                                  break;
                                case "Advanced":
                                  category = '4';
                                  break;
                                default:
                                  category = '1';
                              }

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
                      color: _selectedCategory == ""
                          ? Colors.white
                          : Color.fromRGBO(107, 43, 20, 1.0),
                      disabledColor: Colors.white,
                      disabledTextColor: Color.fromRGBO(107, 43, 20, 1.0),
                      textColor: _selectedCategory == ""
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
