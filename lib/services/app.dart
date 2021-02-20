// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'common.dart';
import 'package:http_parser/http_parser.dart';

Future request(String method, String uri, {dynamic body}) async {
  String appurl = 'https://spicyguitaracademy.com';
  dynamic headers = {'cache-control': 'no-cache', 'JWToken': User.token};
  var response;
  // Navigator.pushNamedAndRemoveUntil(context, '/login_page', (route) => false);
  switch (method) {
    case 'GET':
      response = await http.get(appurl + uri, headers: headers);
      break;
    case 'POST':
      response = await http.post(appurl + uri, headers: headers, body: body);
      break;
    case 'PATCH':
      response = await http.patch(appurl + uri, headers: headers, body: body);
      break;
    case 'PUT':
      response = await http.put(appurl + uri, headers: headers, body: body);
      break;
    case 'DELETE':
      response = await http.delete(appurl + uri, headers: headers);
      break;
    default:
  }
  print("\n\n" + uri + " => " + response.body + "\n\n");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 400 ||
      response.statusCode == 401 ||
      response.statusCode == 403) {
    print('Error: ' + response.statusCode + ', ' + response.body);
    return false;
  } else {
    print('Error: ' + response.statusCode + ', ' + response.body);
  }
}

Future upload(String method, String uri, String filename, dynamic file,
    String contentType,
    {dynamic body}) async {
  String appurl = 'https://spicyguitaracademy.com';
  dynamic headers = {'cache-control': 'no-cache', 'JWToken': User.token};
  http.StreamedResponse response;
  List<String> contentType; // = contentType.split('/');
  // Navigator.pushNamedAndRemoveUntil(context, '/login_page', (route) => false);

  // infer content type from the file basename
  var fileType = file.toString().replaceAll("'", "").split(".").reversed.first;
  switch (fileType) {
    case 'jpg':
      contentType = ["image", "jpeg"];
      break;
    case 'png':
      contentType = ["image", "png"];
      break;
    case 'mp4':
      contentType = ["video", "mp4"];
      break;
    default:
  }

  if (['POST', 'PATCH', 'PUT'].contains(method)) {
    var request = http.MultipartRequest(method, Uri.parse(appurl + uri));
    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath(filename, file.path,
        contentType: new MediaType(contentType[0], contentType[1])));
    request.headers.addAll(headers);

    response = await request.send();
    String responseBody = await response.stream.bytesToString();

    print("\n\n" + uri + " => " + responseBody + "\n\n");
    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 403) {
      print('Error: ' + response.statusCode.toString() + ', ' + responseBody);
      return false;
    } else {
      print('Error: ' + response.statusCode.toString() + ', ' + responseBody);
    }
  }
}

String register = '/api/register';
String login = '/api/login';
String studentStats = '/api/student/statistics';
String subscriptionPlan = '/api/subscription/plans';
String initiatePayment = '/api/subscription/initiate';
String verifyPayment(String reference) => '/api/subscription/verify/$reference';
String chooseCategory = '/api/student/category/select';
String allCourses = '/api/course/all';
String studyingCourses = '/api/student/courses/studying';
String courseLessons(course) => '/api/course/$course/lessons';
String getLesson(int lesson) => '/api/lesson/$lesson';
String studyingLesson(int lesson) => '/api/student/lesson/$lesson';
String nextLesson(int lesson, int course) =>
    '/api/student/lesson/$lesson/next?course=$course';
String prevLesson(int lesson, int course) =>
    '/api/student/lesson/$lesson/previous?course=$course';
String answerAssignment = '/api/student/assignment/answer';
String search(String query) => '/api/courses/search?q=$query';
String invite = '/api/invite-a-friend';
String updateAvatar = '/api/student/avatar/update';
String allQuickLessons = '/api/student/featuredlessons/all';
String quickLessons = '/api/student/featuredlessons';
String quickLesson(int lesson) => '/api/student/featuredlesson/$lesson';
String freeLessons = '/api/student/freelessons';
String subscriptionStatus = '/api/subscription/status';

class App extends Common {
  static String appurl = 'https://spicyguitaracademy.com';
  // static String appurl = 'https://spicyguitaracademy.com';
  static String appName = "Spicy Guitar Academy";
  static String paystackPublicKey =
      'pk_test_2aedc9b8a06baff2b47a08a08cd1b0237c260e4a';

  static Future<bool> signup(scaffold, String firstname, String lastname,
      String email, String telephone, String password, String cpassword) async {
    var resp = await http.post(
      appurl + '/api/register',
      body: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'telephone': telephone,
        'password': password,
        'cpassword': cpassword
      },
    );

    if (resp.statusCode != 200) {
      Common.showMessage(scaffold, 'Registeration Failed.');
      return false;
    } else {
      var respb = resp.body;
      // print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      if (json['success'] != null) {
        showMessage(scaffold, json['success']);
        return true;
      } else {
        // showMessage(scaffold, "Sign up failed");
        showMessage(scaffold, json['errors'][0]);
        return false;
      }
    }
  }

  static Future search(query) async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/courses/search?q=$query',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      // Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future uploadAvatar(String base64Image) async {
    var resp = await http.post(
        'https://spicyguitaracademy.com/api/student/avatar/update',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'},
        body: {'avatar': base64Image});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      // Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static showMessage(scaffoldKey, String message) {
    Common.showMessage(scaffoldKey, message);
  }
}

class User {
  static bool justLoggedIn = false;
  static bool wasLoggedIn = false;
  static String id;
  static String firstname;
  static String lastname;
  static String email;
  static String telephone;
  static String avatar;
  static String token;

  static int category;
  static Map<String, dynamic> categoryStats;

  static String studyingCourse;

  static String subStatus;
  static String plan;
  static int daysRemaining;

  static reset() {
    User.id = null;
    User.firstname = null;
    User.lastname = null;
    User.email = null;
    User.telephone = null;
    User.avatar = null;
    User.token = null;
    User.category = null;
    User.categoryStats = null;
    User.studyingCourse = null;
    User.subStatus = null;
    User.daysRemaining = null;
  }
}

class Courses {
  static Map<String, dynamic> allCourses;
  static List<dynamic> studyingCourses;
  // static String studyingCategory;
  // static Map<String, dynamic> allQuickLessons;
  static List<dynamic> allQuickLessons;
  // static Map<String, dynamic> freeLessons;
  static List<dynamic> freeLessons;
  static Map<String, dynamic> quickLessons;

  static getAllCourses() {
    return Courses.allCourses;
  }
}

class Lessons {
  // the properties on the class
  String thumbnail, tutor, title, description;

  // the constructor
  Lessons(this.thumbnail, this.tutor, this.title, this.description);

  // constructing from json
  Lessons.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    tutor = json['tutor'];
    title = json['title'];
    description = json['description'];
  }
}

class Subscription {
  static String status;
  static String reference;
  // ignore: non_constant_identifier_names
  static String access_code;
  static int price;
  static List<dynamic> plans;

  static bool paystatus;
}

class Tutorial {
  static String id;
  static String title;
  static String description;
  static String thumbnail;
  static String tutor;
  static String video;
  static String audio;
  static String tablature;
  static String note;
  static String practice;
}

class Assignment {
  static String id;
  static String answerId;
  static String questionNote;
  static String questionVideo;
  static String tutor;
  static String tutorId;
  static String answerNote;
  static String answerVideo;
  static String answerRating;
  static String answerDate;
}

List tutorialLessons = [];

dynamic currentTutorial;

void message(context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          scrollable: true,
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.lightBlueAccent),
              Text(" Message", style: TextStyle(color: Colors.lightBlueAccent)),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          content:
              Text(message, style: TextStyle(color: Colors.lightBlueAccent)),
          backgroundColor: Colors.white);
    },
  );
}

void loading(context, {String message = 'Loading'}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new CircularProgressIndicator(),
            new Text("     $message..."),
          ],
        ),
      );
    },
  );
}

void success(context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            Icon(Icons.done, color: Colors.green),
            Text(" Success", style: TextStyle(color: Colors.green)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        content: Text(message, style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
      );
    },
  );
}

void error(context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            Text(" Error", style: TextStyle(color: Colors.red)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        content: Text(message, style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
      );
    },
  );
}

Widget btnIsLoading() {
  return Row(
    children: [
      new CircularProgressIndicator(),
      new Text("  Loading..."),
    ],
  );
}
