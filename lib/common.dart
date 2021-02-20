import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

const String baseUrl = "https://spicyguitaracademy.com";

const String appName = "Spicy Guitar Academy";

const String paystackPublicKey =
    "pk_test_2aedc9b8a06baff2b47a08a08cd1b0237c260e4a";
// pk_live_a62de957d87c74871330cec4084b73f8446fc5ad

// dynamic headers = {'cache-control': 'no-cache', 'JWToken': User.token};

bool reAuthentication = false;

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
  } catch (e) {
    throw Exception(e);
  }
}

// dynamic headers = {'cache-control': 'no-cache', 'JWToken': User.token};
// Navigator.pushNamedAndRemoveUntil(context, '/login_page', (route) => false);

Future upload(String uri, String filename, dynamic file,
    {String method, dynamic body, dynamic headers}) async {
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
    request.fields.addAll(body);
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
  } catch (e) {
    throw Exception(e);
  }
}

void reAuthenticate(context) {
  reAuthentication = true;
  Navigator.pushNamed(context, '/login');
}

void loading(BuildContext context, {String message: 'Loading'}) {
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

void message(BuildContext context, String message, {String title: 'Message'}) {
  showDialog(
    context: context,
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
          content:
              Text(message, style: TextStyle(color: Colors.lightBlueAccent)),
          backgroundColor: Colors.white);
    },
  );
}

void success(BuildContext context, String message, {String title: 'Message'}) {
  showDialog(
    context: context,
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
      );
    },
  );
}

void error(BuildContext context, String message, {String title: 'Error'}) {
  showDialog(
    context: context,
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
      );
    },
  );
}

void snackbar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
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
