
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
