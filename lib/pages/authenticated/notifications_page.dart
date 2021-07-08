import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
// import 'package:spicyguitaracademy/models.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => new NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  // properties
  List<Widget> _notifications = [];
  // TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: brown),
        backgroundColor: grey,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
              color: brown,
              // fontSize: 30,
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: _notifications.length > 0
            ? Column(children: <Widget>[])
            : Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 100),
                  child: Column(
                    children: [
                      Icon(Icons.notifications_off_outlined),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Unavailable for now')
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
