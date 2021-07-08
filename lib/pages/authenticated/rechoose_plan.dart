import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spicyguitaracademy/common.dart';
// import 'package:spicyguitaracademy/models.dart';

class ReChoosePlan extends StatefulWidget {
  @override
  ReChoosePlanState createState() => new ReChoosePlanState();
}

class ReChoosePlanState extends State<ReChoosePlan> {
  // properties
  static const _remaining_days = 0;
  String _selectedPlan = "1Y";

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
            "Choose a Plan",
            textWidthBasis: TextWidthBasis.longestLine,
            style: TextStyle(
                color: brown, fontSize: 35.0, fontWeight: FontWeight.w600),
            strutStyle: StrutStyle(
              fontSize: 35.0,
              height: 1.8,
            ),
          ),
        );
      } else {
        return Column(children: <Widget>[
          Container(
            child: Text("Choose your",
                style: TextStyle(
                    color: brown, fontSize: 35.0, fontWeight: FontWeight.w600)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text("Plan",
                style: TextStyle(
                    color: brown, fontSize: 35.0, fontWeight: FontWeight.w600)),
          ),
        ]);
      }
    }

    return new Scaffold(
        backgroundColor: grey,
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
                    color: brown,
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
                  _titleOrient(orientation),

                  // message test
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: 300,
                    child: Text(
                      _remaining_days > 1
                          ? "You have $_remaining_days days remaining!"
                          : "You have exhausted your subscription plan.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(
                              112, 112, 112, 1.0), //(107, 43, 20, 1.0),
                          fontSize: 20.0),
                    ),
                  ),

                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 20.0),
                  //   width: 300,
                  //   child: Text(
                  //     "You have $_remaining_days days remaining!",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       color: Color.fromRGBO(112, 112, 112, 0.6),
                  //       fontSize: 20.0
                  //     ),
                  //   ),
                  // ),

                  // Category plans
                  Container(
                      margin: const EdgeInsets.only(top: 40.0),
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
                                if (_remaining_days == 0)
                                  setState(() => _selectedPlan = "1M");
                              },
                              color:
                                  _selectedPlan == "1M" ? brown : Colors.white,
                              textColor:
                                  _selectedPlan == "1M" ? Colors.white : brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(color: brown, width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("NGN 3,500",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: SvgPicture.asset(
                                        "assets/imgs/icons/1MS_icon.svg",
                                        matchTextDirection: true,
                                      ),
                                    ),
                                    Text("1 Month",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                  ]),
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
                                if (_remaining_days == 0)
                                  setState(() => _selectedPlan = "3M");
                              },
                              color:
                                  _selectedPlan == "3M" ? brown : Colors.white,
                              textColor:
                                  _selectedPlan == "3M" ? Colors.white : brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(color: brown, width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("NGN 9,600",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: SvgPicture.asset(
                                        "assets/imgs/icons/3MS_icon.svg",
                                        matchTextDirection: true,
                                      ),
                                    ),
                                    Text("3 Months",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                  ]),
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
                                  vertical: 20, horizontal: 25),
                              onPressed: () {
                                if (_remaining_days == 0)
                                  setState(() => _selectedPlan = "6M");
                              },
                              color:
                                  _selectedPlan == "6M" ? brown : Colors.white,
                              textColor:
                                  _selectedPlan == "6M" ? Colors.white : brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(color: brown, width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("NGN 18,000",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: SvgPicture.asset(
                                        "assets/imgs/icons/6MS_icon.svg",
                                        matchTextDirection: true,
                                      ),
                                    ),
                                    Text("6 Months",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                  ]),
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
                                if (_remaining_days == 0)
                                  setState(() => _selectedPlan = "1Y");
                              },
                              color:
                                  _selectedPlan == "1Y" ? brown : Colors.white,
                              textColor:
                                  _selectedPlan == "1Y" ? Colors.white : brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(color: brown, width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("NGN 35,000",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: SvgPicture.asset(
                                        "assets/imgs/icons/1YS_icon.svg",
                                        matchTextDirection: true,
                                      ),
                                    ),
                                    Text("1 Year",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                            ),
                          )
                        ],
                      )),

                  // Payment btn
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 70.0),
                    width: 500,
                    child: RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        onPressed: _selectedPlan == ""
                            ? null
                            : () {
                                Navigator.pushNamed(
                                    context, "/successful_transaction");
                              },
                        color: _selectedPlan == "" ? Colors.white : brown,
                        disabledColor: Colors.white,
                        disabledTextColor: brown,
                        textColor: _selectedPlan == "" ? brown : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            side: BorderSide(color: brown, width: 2.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.credit_card, size: 25.0),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: Text("Payment Method",
                                  style: TextStyle(fontSize: 20.0)),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 25.0),
                          ],
                        )),
                  ),
                ],
              ),
            ])),
          );
        }));
  }
}
