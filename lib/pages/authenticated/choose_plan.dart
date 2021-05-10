import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class ChoosePlan extends StatefulWidget {
  @override
  ChoosePlanState createState() => new ChoosePlanState();
}

class ChoosePlanState extends State<ChoosePlan> {
  CheckoutMethod _method = CheckoutMethod.selectable;
  // bool _inProgress = false;

  // properties
  String _selectedPlan;

  @override
  void initState() {
    // _loadSubscriptionPlans();
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    super.initState();
    _selectedPlan = Student.subscriptionPlan;
  }

  @override
  Widget build(BuildContext context) {
    // final Map args = ModalRoute.of(context).settings.arguments as Map;
    // _selectedPlan = args['selectedplan'];
    // bool isLoading = false;

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
        ..email = Student.email
        ..card = _getCardFromUI();

      charge.accessCode = Subscription.accessCode;

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
          await Subscription.verifySubscription();
          Navigator.pop(context);
          if (Subscription.paystatus == true) {
            Navigator.popAndPushNamed(context, "/successful_transaction");
          } else {
            Navigator.pushNamed(context, "/failed_transaction");
          }
        } else {
          Navigator.pushNamed(context, "/failed_transaction");
          Navigator.pop(context);
        }
      } catch (e) {
        error(context, stripExceptions(e));
      }
    }

    return new Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: brown),
          backgroundColor: grey,
          centerTitle: true,
          title: Text(
            'Choose a Plan',
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Container(
                        width: screen(context).width * 0.4,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          onPressed: () => Student.subscription == false
                              ? setState(() => _selectedPlan =
                                  Subscription.plans[0]['plan_id'])
                              : null,
                          color:
                              _selectedPlan == Subscription.plans[0]['plan_id']
                                  ? brown
                                  : Colors.white,
                          textColor:
                              _selectedPlan == Subscription.plans[0]['plan_id']
                                  ? Colors.white
                                  : brown,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: brown, width: 2.0)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                    "NGN ${Subscription.plans[0]['price']}\n/mo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
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
                        width: screen(context).width * 0.4,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          onPressed: () => Student.subscription == false
                              ? setState(() => _selectedPlan =
                                  Subscription.plans[1]['plan_id'])
                              : null,
                          color:
                              _selectedPlan == Subscription.plans[1]['plan_id']
                                  ? brown
                                  : Colors.white,
                          textColor:
                              _selectedPlan == Subscription.plans[1]['plan_id']
                                  ? Colors.white
                                  : brown,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: brown, width: 2.0)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                    "NGN ${Subscription.plans[1]['price']}\n/mo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
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
                  ),

                  SizedBox(height: 30.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: screen(context).width * 0.4,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          onPressed: () => Student.subscription == false
                              ? setState(() => _selectedPlan =
                                  Subscription.plans[2]['plan_id'])
                              : null,
                          color:
                              _selectedPlan == Subscription.plans[2]['plan_id']
                                  ? brown
                                  : Colors.white,
                          textColor:
                              _selectedPlan == Subscription.plans[2]['plan_id']
                                  ? Colors.white
                                  : brown,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: brown, width: 2.0)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                    "NGN ${Subscription.plans[2]['price']}\n/mo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
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
                        width: screen(context).width * 0.4,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          onPressed: () => Student.subscription == false
                              ? setState(() => _selectedPlan =
                                  Subscription.plans[3]['plan_id'])
                              : null,
                          color:
                              _selectedPlan == Subscription.plans[3]['plan_id']
                                  ? brown
                                  : Colors.white,
                          textColor:
                              _selectedPlan == Subscription.plans[3]['plan_id']
                                  ? Colors.white
                                  : brown,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: brown, width: 2.0)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                    "NGN ${Subscription.plans[3]['price']}\n/mo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
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
                  ),

                  SizedBox(height: 20.0),

                  Student.subscription == false && Student.isLoaded == false
                      ? Container(
                          // alignment: Alignment.center,
                          // margin: const EdgeInsets.symmetric(vertical: 20.0),
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
                        )
                      : SizedBox(
                          height: 30.0,
                        ),

                  SizedBox(height: 20.0),

                  Student.subscription == false
                      ? Container(
                          width: screen(context).width - 40,
                          child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              textColor: Colors.white,
                              disabledColor: Colors.white,
                              onPressed: _selectedPlan == "0"
                                  ? null
                                  : () async {
                                      try {
                                        loading(context);
                                        await Subscription.initiatePayment(
                                            _selectedPlan);
                                        _handleCheckout(context);
                                      } catch (e) {
                                        Navigator.pop(context);
                                        error(context, stripExceptions(e));
                                      }
                                    },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.credit_card, size: 25.0),
                                  SizedBox(width: 10.0),
                                  Text("Continue Payment",
                                      style: TextStyle(fontSize: 20.0)),
                                ],
                              )),
                        )
                      : Container(),

                  SizedBox(height: 20),

                  // if student subscription is expired, offer free
                  Student.subscription == false && Student.isLoaded == false
                      ? Container(
                          width: screen(context).width - 40,
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 20),
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, "/ready_to_play");
                            },
                            child: Text("Continue",
                                style: TextStyle(fontSize: 20.0)),
                          ),
                        )
                      : Container(),

                  SizedBox(height: 40),
                ]))));
  }
}

// Payment should subscriptional
// N7000/Mo for 1 Month
// N6500/Mo for 3 Month
// N6000/Mo for 6 Month
// N5000/Mo for 12 Month
