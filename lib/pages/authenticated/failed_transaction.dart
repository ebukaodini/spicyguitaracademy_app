import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailedTransaction extends StatefulWidget{
  @override
  FailedTransactionState createState() => new FailedTransactionState();
}

class FailedTransactionState extends State<FailedTransaction>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
      body: OrientationBuilder(
        
        builder: (context, orientation) {
          return 
          SafeArea(
            minimum: EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.symmetric(horizontal: 35),
                height: orientation == Orientation.portrait ? MediaQuery.of(context).copyWith().size.height: 700,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    
                    Container(
                      margin: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        "Transaction",
                        style: TextStyle(
                          color: Color.fromRGBO(107, 43, 20, 1.0),
                          fontSize: 40.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        "Failed",
                        style: TextStyle(
                          color: Color.fromRGBO(107, 43, 20, 1.0),
                          fontSize: 40.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
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
                      width: orientation == Orientation.portrait ? MediaQuery.of(context).copyWith().size.width : 400,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        onPressed: () {Navigator.popAndPushNamed(context, "/choose_plan");},
                        color: Color.fromRGBO(107, 43, 20, 1.0),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide( color: Color.fromRGBO(107, 43, 20, 1.0), width: 2.0 )
                        ),
                        
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: Text("Go Back",style: TextStyle( fontSize: 20.0)),
                        ),
                        
                      ),
                    ),

                  ]
                ),
              ),

            )
          );
        }
      )
    );

  }

}