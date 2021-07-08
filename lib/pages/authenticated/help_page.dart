import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
// import 'package:spicyguitaracademy/models.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HelpPage extends StatefulWidget {
  @override
  HelpPageState createState() => new HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  // properties
  List<Widget> _searchResult = [];

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
          'Help',
          style: TextStyle(
              color: brown,
              fontSize: 30,
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                Icon(Icons.help_outline),
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
