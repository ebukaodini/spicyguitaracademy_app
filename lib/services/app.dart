import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'common.dart';

Future request(String method, String uri, {dynamic body}) async {
  String appurl = 'https://spicyguitaracademy.com';
  // String appurl = 'https://spicyguitaracademy.com';
  dynamic headers = {'cache-control': 'no-cache', 'JWToken': User.token};
  var response;
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
String allQuickLessons = '/api/student/quicklessons/all';
String quickLessons = '/api/student/quicklessons';
String quickLesson(int lesson) => '/api/student/quicklesson/$lesson';
String freeLessons = '/api/student/freelessons';
String subscriptionStatus = '/api/subscription/status';
// String register = '/api/register';

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

  static Future<bool> login(scaffold, String email, String password) async {
    User.reset();
    var resp = await http.post('https://spicyguitaracademy.com/api/login',
        body: {'email': email, 'password': password});
    // j.hamlet@gmail.com
    // Jhamlett09

    if (resp.statusCode != 200) {
      showMessage(scaffold, 'Login Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(scaffold, respb);
      if (json['success'] != '') {
        User.firstname = json['student']['firstname'];
        User.lastname = json['student']['lastname'];
        User.email = json['student']['email'];
        User.telephone = json['student']['telephone'];
        User.id = json['student']['id'];
        User.avatar = json['student']['avatar'];
        User.token = json['token'];
        User.justLoggedIn = true;
        print(User.token);
        showMessage(scaffold, json['success']);

        // set the student subscription details
        getUserSubscriptionStatus();

        // get the student's category and stats
        studentStatistics();

        // get subscription plans
        getSubscriptionPlans();

        return true;
      } else {
        showMessage(scaffold, json['errors']);
        return false;
      }
    }
  }

  static studentStatistics() async {
    var resp = await http
        .get('https://spicyguitaracademy.com/api/student/statistics', headers: {
      'cache-control': 'no-cache',
      'JWToken': User.token,
    });

    if (resp.statusCode != 200) {
      print('Getting Student Subscription Status Failed (${resp.statusCode}).');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      print(json['status']);
      if (json['status'] == false) {
        User.categoryStats = null;
        User.category = null;
      } else {
        User.categoryStats = json['stats'];
        User.category = json['category'];
      }
      print("student stats is ${json['category']}");
    }
  }

  static getSubscriptionPlans() async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/subscription/plans',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('Getting Subscription Plans Failed.');
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      Subscription.plans = json['plans'];
    }
  }

  static getUserSubscriptionStatus() async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/subscription/status',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      User.subStatus = json['status'];
      User.daysRemaining = json['days'];
    }
  }

  static Future initiatePayment(scaffold, String plan) async {
    var resp = await http.post(
        'https://spicyguitaracademy.com/api/subscription/initiate',
        headers: {'JWToken': User.token},
        body: {'email': User.email, 'plan': plan});

    if (resp.statusCode != 200) {
      showMessage(scaffold, 'Initiate Subscription Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      if (json['flag'] == true) {
        Subscription.reference = json['data']['reference'];
        Subscription.access_code = json['data']['access_code'];
        Subscription.price = json['data']['price'];
      } else {
        showMessage(scaffold, 'Initiate Subscription Failed.');
      }
      return true;
    }
  }

  static Future verifyPayment(String reference) async {
    var resp = await http.post(
        "https://spicyguitaracademy.com/api/subscription/verify/$reference",
        headers: {'JWToken': User.token},
        body: {'plan': reference});

    if (resp.statusCode != 200) {
      print('Error Occurred.');
    } else {
      final respb = resp.body;
      Map<String, dynamic> json = jsonDecode(respb);
      if (json['success']) {
        Subscription.paystatus = true;
        getUserSubscriptionStatus();
      }
    }
  }

  static Future chooseCategory(String category) async {
    var resp = await http.post(
        'https://spicyguitaracademy.com/api/student/category/select',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'},
        body: {'category': category});

    if (resp.statusCode != 200) {
      print('Getting Student Subscription Status Failed. (${resp.body}) ');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      print("response message: ${json['message']}");

      await studentStatistics();
    }
  }

  static Future getAllCourses() async {
    var resp = await http.get('https://spicyguitaracademy.com/api/course/all',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      Courses.allCourses = json;
      return true;
    }
  }

  static Future studyingCourses() async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/student/courses/studying',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      Courses.studyingCourses = json['courses'];
      print(json['courses']);
      return true;
    }
  }

  static Future courseLessons(int course) async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/course/$course/lessons',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future getLesson(int lesson) async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/lesson/$lesson',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future studyingLesson(lesson) async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/student/lesson/$lesson',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future nextLesson(lesson) async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/student/lesson/$lesson/next?course=${User.studyingCourse}',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future prevLesson(lesson) async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/student/lesson/$lesson/previous?course=${User.studyingCourse}',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future answerAssignment(assignment) async {
    var resp = await http.post(
        'https://spicyguitaracademy.com/api/student/assignment/answer',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'},
        body: {'assignment': assignment});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
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
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future inviteAFriend(String friend) async {
    var resp = await http.post(
        'https://spicyguitaracademy.com/api/invite-a-friend',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'},
        body: {'friend': friend});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
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
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future quicklessons() async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/student/quicklessons',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future quicklesson(lesson) async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/student/quicklesson/$lesson',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      // showMessage(json['status']);
      return true;
    }
  }

  static Future freelesson() async {
    var resp = await http.get(
        'https://spicyguitaracademy.com/api/student/freelessons',
        headers: {'JWToken': User.token, 'cache-control': 'no-cache'});

    if (resp.statusCode != 200) {
      print('${resp.statusCode} Getting Student Subscription Status Failed.');
      return false;
    } else {
      var respb = resp.body;
      print(respb);
      Map<String, dynamic> json = jsonDecode(respb);
      if (json['lessons'] != null) Courses.freeLessons = json['lessons'];
      print(Courses.freeLessons);
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

  static String category;
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
