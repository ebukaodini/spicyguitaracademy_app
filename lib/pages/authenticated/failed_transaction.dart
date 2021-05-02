import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spicyguitaracademy/common.dart';

class FailedTransaction extends StatefulWidget {
  @override
  FailedTransactionState createState() => new FailedTransactionState();
}

class FailedTransactionState extends State<FailedTransaction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: 35),
        height: screen(context).height,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "Transaction Failed",
                  style: TextStyle(
                    color: brown,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50.0),
                child: SvgPicture.asset(
                  "assets/imgs/icons/payment_failed_icon.svg",
                  matchTextDirection: true,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                width: screen(context).width,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: brown,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: brown, width: 2.0)),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Text("Go Back", style: TextStyle(fontSize: 20.0)),
                  ),
                ),
              ),
            ]),
      ),
    ));
  }
}
