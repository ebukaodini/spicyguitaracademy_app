import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../services/app.dart';
import '../../services/common.dart';

class ChoosePlan extends StatefulWidget {
  @override
  ChoosePlanState createState() => new ChoosePlanState();
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "CO",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

const Color green = const Color(0xFF3db76d);
const Color lightBlue = const Color(0xFF34a5db);
const Color navyBlue = const Color(0xFF031b33);

class ChoosePlanState extends State<ChoosePlan> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  CheckoutMethod _method = CheckoutMethod.card;
  // bool _inProgress = false;

  // properties
  String _selectedPlan = "";

  @override
  void initState() {
    // _loadSubscriptionPlans();
    PaystackPlugin.initialize(publicKey: App.paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  final Map args = ModalRoute.of(context).settings.arguments as Map;
    _selectedPlan = args['plan'];

    PaymentCard _getCardFromUI() {
      return PaymentCard(
        number: '',
        cvc: '',
        expiryMonth: 0,
        expiryYear: 0,
      );
    }

    _handleCheckout(BuildContext context) async {
      Charge charge = Charge()
        ..amount = Subscription.price // In base currency
        ..email = User.email
        ..card = _getCardFromUI();

      charge.accessCode = Subscription.access_code;

      try {
        CheckoutResponse response = await PaystackPlugin.checkout(
          context,
          method: _method,
          charge: charge,
          fullscreen: true,
          logo: SvgPicture.asset(
            "assets/imgs/icons/spicy_guitar_logo.svg",
            width: 40.0,
            matchTextDirection: true,
          ),
        );

        if (response.verify == true) {
          var resp = await request(
              'POST', verifyPayment(Subscription.reference),
              body: {'email': User.email});
          if (resp == false)
            Navigator.pushNamedAndRemoveUntil(
                context, '/login_page', (route) => false);
          Map<String, dynamic> json = resp;
          if (json['success'] != null) {
            Subscription.paystatus = true;
            {
              // get subscription status
              var resp = await request('GET', subscriptionStatus);
              if (resp == false)
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login_page', (route) => false);
              Map<String, dynamic> json = resp;
              User.subStatus = json['status'];
              User.daysRemaining = json['days'];
              User.plan = json['plan'] ?? '0';
            }

            Navigator.popAndPushNamed(context, "/successful_transaction");
          } else {
            Navigator.pushNamed(context, "/failed_transaction");
          }
        }
      } catch (e) {
        App.showMessage(_scaffoldKey, 'Check console for error: $e');
        rethrow;
      }
    }

    _titleOrient(orientation) {
      // await _loadSubscriptionPlans();
      if (orientation == Orientation.landscape) {
        return Container(
          child: Text(
            "Choose a Plan",
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
            child: Text("Plan",
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
                              onPressed: () => setState(() => _selectedPlan =
                                  Subscription.plans[0]['plan_id']),
                              color: _selectedPlan ==
                                      Subscription.plans[0]['plan_id']
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedPlan ==
                                      Subscription.plans[0]['plan_id']
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                        "NGN " + Subscription.plans[0]['price'],
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
                                    Text(Subscription.plans[0]['plan'],
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
                              onPressed: () => setState(() => _selectedPlan =
                                  Subscription.plans[1]['plan_id']),
                              color: _selectedPlan ==
                                      Subscription.plans[1]['plan_id']
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedPlan ==
                                      Subscription.plans[1]['plan_id']
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                        "NGN " + Subscription.plans[1]['price'],
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
                                    Text(Subscription.plans[1]['plan'],
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
                                  vertical: 20, horizontal: 30),
                              onPressed: () => setState(() => _selectedPlan =
                                  Subscription.plans[2]['plan_id']),
                              color: _selectedPlan ==
                                      Subscription.plans[2]['plan_id']
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedPlan ==
                                      Subscription.plans[2]['plan_id']
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                        "NGN " + Subscription.plans[2]['price'],
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
                                    Text(Subscription.plans[2]['plan'],
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
                              onPressed: () => setState(
                                () => _selectedPlan =
                                    Subscription.plans[3]['plan_id'],
                              ),
                              color: _selectedPlan ==
                                      Subscription.plans[3]['plan_id']
                                  ? Color.fromRGBO(107, 43, 20, 1.0)
                                  : Colors.white,
                              textColor: _selectedPlan ==
                                      Subscription.plans[3]['plan_id']
                                  ? Colors.white
                                  : Color.fromRGBO(107, 43, 20, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(107, 43, 20, 1.0),
                                      width: 2.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                        "NGN " + Subscription.plans[3]['price'],
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
                                    Text(Subscription.plans[3]['plan'],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                            ),
                          )
                        ],
                      )),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: 300,
                    child: Text(
                      "Tap Continue to watch free lessons or to buy Special Courses.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 0.6),
                          fontSize: 16.0),
                      strutStyle: StrutStyle(
                        fontSize: 20.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 500,
                    child: RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        onPressed: _selectedPlan == ""
                            ? null
                            : () async {
                                // bool resp = await App.initiatePayment(_scaffoldKey, _selectedPlan);
                                var resp = await request(
                                    'POST', initiatePayment, body: {
                                  'email': User.email,
                                  'plan': _selectedPlan
                                });
                                if (resp == false)
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login_page', (route) => false);
                                Map<String, dynamic> json = resp;
                                if (json['flag'] == true) {
                                  Subscription.reference =
                                      json['data']['reference'];
                                  Subscription.access_code =
                                      json['data']['access_code'];
                                  Subscription.price = json['data']['price'];

                                  _handleCheckout(context);
                                } else {
                                  Common.showInfo(
                                      _scaffoldKey, 'Please select a plan');
                                }
                                // Navigator.pushNamed(context, "/paystack_page");
                              },
                        color: _selectedPlan == ""
                            ? Colors.white
                            : Color.fromRGBO(107, 43, 20, 1.0),
                        disabledColor: Colors.white,
                        disabledTextColor: Color.fromRGBO(107, 43, 20, 1.0),
                        textColor: _selectedPlan == ""
                            ? Color.fromRGBO(107, 43, 20, 1.0)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                width: 2.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.credit_card, size: 25.0),

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Continue Payment",
                                  style: TextStyle(fontSize: 20.0)),
                            ),

                            // Icon(Icons.arrow_forward_ios, size: 25.0),
                          ],
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: 500, //MediaQuery.of(context).copyWith().size.width,
                    child: RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        onPressed: () {
                          Navigator.pushNamed(context, "/ready_to_play");
                        },
                        color: Color.fromRGBO(107, 43, 20, 1.0),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Color.fromRGBO(107, 43, 20, 1.0),
                                width: 2.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: Text("Continue",
                                  style: TextStyle(fontSize: 20.0)),
                            ),
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
