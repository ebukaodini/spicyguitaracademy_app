import 'package:flutter/material.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:spicyguitaracademy/models.dart';

class SearchPage extends StatefulWidget {
  
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  // properties
  String _searchValue = "";
  TextEditingController _searchController = TextEditingController();

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
          return SafeArea(
            minimum: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20, left: 2, bottom: 10),
                      child: MaterialButton(
                        minWidth: 20,
                        color: Colors.white,
                        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        onPressed: (){ Navigator.pop(context);},
                        child: new Icon(Icons.arrow_back_ios, color: Color.fromRGBO(107, 43, 20, 1.0), size: 20.0,),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.white)
                        ),
                      ),
                      
                    ),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Text(
                            "Looking for something?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(107, 43, 20, 1.0),
                              fontSize: 25.0,fontWeight: FontWeight.w600
                            )
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40, vertical:10 ),
                          child: Text(
                            "Search for anything, we are always ready to help.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 1.0),
                              fontSize: 20.0,fontWeight: FontWeight.w400
                            )
                          ),
                        ),

                        // Search container
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10, ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              Container(
                                width: MediaQuery.of(context).copyWith().size.width - 130,
                                // color: Colors.white,
                                child: TextField(
                                  controller: _searchController,
                                  cursorColor: Color.fromRGBO(112, 112, 112, 1.0),
                                  autofocus: true,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (String value) {
                                    setState((){
                                      _searchValue = value;
                                      _searchController.clear();
                                      // use this to default value, maybe from a db
                                      // _searchController.value = TextEditingValue(text: "Hi");
                                    });
                                  },
                                  style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1.0),
                                    fontSize: 20.0,
                                    height: 1.6
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    fillColor: Colors.white,
                                    focusColor: Color.fromRGBO(107, 43, 20, 1.0),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                    border: InputBorder.none,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0 )
                                  ],
                                )
                              ),

                              Container(
                                child: MaterialButton(
                                  minWidth: 20,
                                  color: Color.fromRGBO(107, 43, 20, 1.0),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                                  onPressed: () {
                                    setState(() {
                                      // init search
                                      _searchValue = _searchController.text;
                                      _searchController.clear();
                                    });
                                    // TODO: handle search and load results in a page
                                    Navigator.popAndPushNamed(context, '/dashboard');
                                  },
                                  child: new Icon(Icons.search, color: Colors.white, size: 25.0,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(15.0),
                                    side: BorderSide(color: Color.fromRGBO(107, 43, 20, 1.0))
                                  ),
                                ),
                              ),

                            ],
                          )
                        ),
 
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                          width: 300,
                          child: Text(
                            _searchValue,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(112, 112, 112, 0.6),
                              fontSize: 16.0
                            ),
                            strutStyle: StrutStyle(
                              fontSize: 20.0,
                              height: 1.3,
                            ),
                          ),
                        ),
                      
                    //   ],
                    // ),
                    
                  ]
                )

              ),
              
          );
        }

      )
    );

  }

}
