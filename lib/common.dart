// import 'dart:html';
import 'dart:io';

import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:spicyguitaracademy/models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class AuthException {
  AuthException(String message) {
    throw Exception(message);
  }
}

const String baseUrl = "https://spicyguitaracademy.com";
// const String baseUrl = "http://10.0.2.2/sga_web";
// const String baseUrl = "http://localhost/sga_web";

const String appName = "Spicy Guitar Academy";

String paystackPublicKey;

// dynamic headers = {'cache-control': 'no-cache', 'JWToken': Student.token};

bool reAuthentication = false;

// dynamic headers = {'cache-control': 'no-cache', 'JWToken': Student.token};
// Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

// class Http {

// static
Future request(String uri,
    {String method, dynamic body, dynamic headers}) async {
  try {
    var response;
    switch (method) {
      case 'GET':
        response = await http.get(baseUrl + uri, headers: headers);
        break;
      case 'POST':
        response = await http.post(baseUrl + uri, headers: headers, body: body);
        break;
      case 'PATCH':
        response =
            await http.patch(baseUrl + uri, headers: headers, body: body);
        break;
      case 'PUT':
        response = await http.put(baseUrl + uri, headers: headers, body: body);
        break;
      case 'DELETE':
        response = await http.delete(baseUrl + uri, headers: headers);
        break;
      default:
        response = await http.get(baseUrl + uri, headers: headers);
        break;
    }

    print("\n\n" + uri + " => " + response.body + "\n\n");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      switch (response.statusCode) {
        case 401:
          throw AuthException("Session Timed Out");
          break;
        case 403:
          throw AuthException("Authorization Failed");
          break;
        case 500:
          throw Exception("Server Error");
          break;
        default:
          throw Exception("Unknown Error");
          break;
      }
    }
  } on SocketException catch (e) {
    print(e);
    throw Exception("Network Error");
  } catch (e) {
    throw Exception(e);
  }
}

// static
Future upload(String uri, String filename, dynamic file,
    {String method, Map<String, String> body, dynamic headers}) async {
  try {
    http.StreamedResponse response;
    List<String> contentType;

    if (['POST', 'PATCH', 'PUT'].contains(method) == false) {
      throw Exception("Invalid Http Method");
    }

    // infer content type from the file basename
    var fileType =
        file.toString().replaceAll("'", "").split(".").reversed.first;
    switch (fileType) {
      case 'jpg':
      case 'jpeg':
        contentType = ["image", "jpeg"];
        break;
      case 'png':
        contentType = ["image", "png"];
        break;
      case 'mp3':
        contentType = ["audio", "mp3"];
        break;
      case 'mp4':
        contentType = ["video", "mp4"];
        break;
      default:
    }

    var request = http.MultipartRequest(method, Uri.parse(baseUrl + uri));
    if (body != null) request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath(filename, file.path,
        contentType: new MediaType(contentType[0], contentType[1])));
    request.headers.addAll(headers);
    response = await request.send();
    String responseBody = await response.stream.bytesToString();

    if (['POST', 'PATCH', 'PUT'].contains(method)) {
      print("\n\n" + uri + " => " + responseBody + "\n\n");

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        switch (response.statusCode) {
          case 401:
            throw Exception("Session Timed Out");
            break;
          case 403:
            throw Exception("Authorization Failed");
            break;
          case 500:
            throw Exception("Server Error");
            break;
          default:
            throw Exception("Unknown Error");
            break;
        }
      }
    }
  } on SocketException catch (e) {
    print(e);
    throw Exception("Network Error");
  } on AuthException catch (e) {
    throw AuthException(e.toString());
  } catch (e) {
    throw Exception(e);
  }
}

void reAuthenticate(context) {
  reAuthentication = true;
  Navigator.pushNamed(context, '/login');
}

screen(BuildContext context) {
  return MediaQuery.of(context).copyWith().size;
}

void loading(BuildContext context, {String message: 'Loading'}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 20.0,
            ),
            Text("$message..."),
          ],
        ),
      );
    },
  );
}

void message(BuildContext context, String message, {String title: 'Message'}) {
  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            Icon(Icons.info, color: Colors.lightBlueAccent),
            SizedBox(width: 2.0),
            Text("$title", style: TextStyle(color: Colors.lightBlueAccent)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        content: Column(
          children: [
            Text(message, style: TextStyle(color: Colors.lightBlueAccent)),
          ],
        ),
        backgroundColor: Colors.white,
        // actions: [
        //   MaterialButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text('Ok'),
        //   )
        // ],
      );
    },
  );
}

void success(BuildContext context, String message, {String title: 'Message'}) {
  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            Icon(Icons.done, color: Colors.green),
            SizedBox(width: 2.0),
            Text("$title", style: TextStyle(color: Colors.green)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        content: Text(message, style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        // actions: [
        //   MaterialButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text('Ok'),
        //   )
        // ],
      );
    },
  );
}

void error(BuildContext context, String message, {String title: 'Error'}) {
  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 2.0),
            Text("$title", style: TextStyle(color: Colors.red)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        content: Text(message, style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
        // actions: [
        //   MaterialButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text('Ok'),
        //   )
        // ],
      );
    },
  );
  // SnackBar(
  //   content: Text(message, style: TextStyle(color: Colors.red)),
  //   backgroundColor: Colors.white
  // );
}

void snackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Widget backButton(context,
    {double radius: 5,
    double size: 20,
    double minWidth: 20,
    double padding: 20}) {
  return MaterialButton(
    minWidth: minWidth,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding - 2),
    onPressed: () {
      Navigator.pop(context);
    },
    child: new Icon(Icons.arrow_back, color: brown, size: size),
    shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(radius),
        side: BorderSide(color: Colors.white)),
  );
}

Color brown = Color(0xFF6B2B14);
Color darkbrown = Color(0xFF471D0E);
Color grey = Color(0xFFF3F3F3);
Color darkgrey = Color(0xFF707070);

String defaultThumbnail = "assets/imgs/pictures/course_img_default.jpg";
String beginnersThumbnail = "assets/imgs/pictures/beginners_thumbnail.jpg";
String amateurThumbnail = "assets/imgs/pictures/amateur_thumbnail.jpg";
String intermediateThumbnail =
    "assets/imgs/pictures/intermediate_thumbnail.jpg";
String advancedThumbnail = "assets/imgs/pictures/advanced_thumbnail.jpg";

String getStudentCategoryThumbnail({int category = -1}) {
  switch (category > -1 ? category : Student.studyingCategory) {
    case 0:
      return defaultThumbnail;
    case 1:
      return beginnersThumbnail;
    case 2:
      return amateurThumbnail;
    case 3:
      return intermediateThumbnail;
    case 4:
      return advancedThumbnail;
    default:
      return defaultThumbnail;
  }
}

String stripExceptions(errmsg) {
  return errmsg.toString().replaceAll("Exception: ", "");
}

Widget renderCourse(Course course, context, Function callback,
    {bool showProgress = true, bool showPricings = false}) {
  return CupertinoButton(
    onPressed: () => callback(),
    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
    child: Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0)
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: screen(context).width * 0.28,
            height: 100,
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$baseUrl/${course.thumbnail}',
                    headers: {'cache-control': 'max-age=0, must-revalidate'}),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            child: course.status == false
                ? SvgPicture.asset("assets/imgs/icons/lock_icon.svg",
                    color: Colors.white, fit: BoxFit.scaleDown)
                : SvgPicture.asset(
                    "assets/imgs/icons/play_video_icon.svg",
                    color: Colors.white,
                    fit: BoxFit.scaleDown,
                  ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course.tutor,
                            style: TextStyle(
                                color: darkgrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(course.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: brown,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800))),
                            Text(
                              "${course.allLessons} lessons",
                              style: TextStyle(
                                  color: darkgrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                        Text(course.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: darkgrey)),
                        SizedBox(height: 5),
                        showProgress == true
                            ? Column(
                                children: [
                                  // progress indicator
                                  Stack(
                                    alignment: Alignment.topLeft,
                                    children: <Widget>[
                                      // background
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: FractionallySizedBox(
                                          widthFactor: 1.0,
                                          child: Container(
                                            height: 2.0,
                                            color: grey,
                                          ),
                                        ),
                                      ),

                                      // indicator
                                      FractionallySizedBox(
                                        widthFactor: course.completedLessons ==
                                                0
                                            ? 0.005

                                            // conditional stmt to capture when
                                            // completed lesson is greater than
                                            // all lessons
                                            : (course.completedLessons <=
                                                    course.allLessons
                                                ? (course.completedLessons /
                                                    course.allLessons)
                                                : 1),
                                        child: Container(
                                          height: 2.0,
                                          color: brown,
                                        ),
                                      )
                                    ],
                                  ),
                                  // progress note
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${course.completedLessons} of ${course.allLessons} lessons",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: darkgrey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800),
                                      ))
                                ],
                              )
                            : SizedBox(),
                        showPricings == true
                            ?
                            // display price
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "₦${course.featuredprice}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: darkgrey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ))
                            : SizedBox(),
                      ]))),
          SizedBox(width: 10)
        ],
      ),
    ),
  );
}

Widget loadImage(context, dynamic course, String url) {
  // return NetworkImage('$baseUrl/${course.thumbnail}',
  // headers: {'cache-control': 'max-age=1000000'});
  return new Container(
    // margin: EdgeInsets.only(bottom: 10),
    width: screen(context).width * 0.28,
    height: 100,
    decoration: new BoxDecoration(
      image: DecorationImage(
        image: NetworkImage('$baseUrl/${course.thumbnail}',
            headers: {'cache-control': 'max-age=0, must-revalidate'}),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
    ),
    child: course.status == false
        ? SvgPicture.asset("assets/imgs/icons/lock_icon.svg",
            color: Colors.white, fit: BoxFit.scaleDown)
        : SvgPicture.asset(
            "assets/imgs/icons/play_video_icon.svg",
            color: Colors.white,
            fit: BoxFit.scaleDown,
          ),
  );
  // FutureBuilder(
  //   future: http.get(url, headers: {'cache-control': 'max-age=1000000'}),
  //   builder: (context, snapshot) {
  //     if (snapshot.connectionState == ConnectionState.done) {
  //       print("completed snapshot $snapshot");
  //       return Container();
  //       // return new Container(
  //       //   width: screen(context).width * 0.28,
  //       //   height: 120,
  //       //   decoration: new BoxDecoration(
  //       //     image: DecorationImage(
  //       //       image: FileImage(snapshot.data),
  //       //       // NetworkImage('$baseUrl/${course.thumbnail}',
  //       //       //       headers: {'cache-control': 'max-age=0, must-revalidate'}),
  //       //       fit: BoxFit.cover,
  //       //     ),
  //       //     borderRadius: BorderRadius.only(
  //       //         bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
  //       //   ),
  //       //   child: course.status == false
  //       //       ? SvgPicture.asset("assets/imgs/icons/lock_icon.svg",
  //       //           color: Colors.white, fit: BoxFit.scaleDown)
  //       //       : SvgPicture.asset(
  //       //           "assets/imgs/icons/play_video_icon.svg",
  //       //           color: Colors.white,
  //       //           fit: BoxFit.scaleDown,
  //       //         ),
  //       // );
  //     } else {
  //       print("not completed snapshot $snapshot");
  //       return Container();
  //       // return new Container(
  //       //   width: screen(context).width * 0.28,
  //       //   height: 120,
  //       //   child:
  //       //       Image.asset("assets/imgs/icons/unloaded.png", fit: BoxFit.cover),
  //       // );
  //     }
  //   },
  // );
}

Widget renderLesson(Lesson lesson, context, Function callback,
    {bool courseLocked = true}) {
  return CupertinoButton(
    onPressed: () => (courseLocked == false) ? callback() : null,
    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
    child: Container(
      padding: EdgeInsets.only(bottom: 20),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0)
        ],
      ),
      child: Column(
        children: <Widget>[
          // add the thumbnail for the lesson
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: screen(context).width,
            height: 120,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage('$baseUrl/${lesson.thumbnail}',
                    headers: {'cache-control': 'max-age=0, must-revalidate'}),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: courseLocked == true
                ? SvgPicture.asset("assets/imgs/icons/lock_icon.svg",
                    color: Colors.white, fit: BoxFit.scaleDown)
                : SvgPicture.asset(
                    "assets/imgs/icons/play_video_icon.svg",
                    color: Colors.white,
                    fit: BoxFit.scaleDown,
                  ),
          ),
          Container(
              width: screen(context).width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(children: [
                Text(
                  "${lesson.title}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: brown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  lesson.tutor,
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${lesson.description}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1.0),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ])),
        ],
      ),
    ),
  );
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

Widget renderAssignment(context) {
  return CupertinoButton(
      onPressed: () {
        Navigator.pushNamed(context, '/assignment_page');
      },
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10.0, spreadRadius: 2.0)
            ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Course Assignment",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: brown,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  Assignment.tutor ?? 'No Tutor',
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  Assignment.questionNote ?? 'No note',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1.0),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Answer Ratings', style: TextStyle(color: brown)),
                Row(
                  children: [
                    Icon(
                        Assignment.answerRating > 0
                            ? Icons.star
                            : Icons.star_border_outlined,
                        color: brown),
                    Icon(
                        Assignment.answerRating > 1
                            ? Icons.star
                            : Icons.star_border_outlined,
                        color: brown),
                    Icon(
                        Assignment.answerRating > 2
                            ? Icons.star
                            : Icons.star_border_outlined,
                        color: brown),
                    Icon(
                        Assignment.answerRating > 3
                            ? Icons.star
                            : Icons.star_border_outlined,
                        color: brown),
                    Icon(
                        Assignment.answerRating > 4
                            ? Icons.star
                            : Icons.star_border_outlined,
                        color: brown),
                  ],
                )
              ])));
}

setCurrentTutorial(Lesson tut) {
  currentTutorial = tut;
  // final SharedPreferences prefs = await _prefs;
  // prefs.set
}
