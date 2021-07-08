// import 'package:sanitize_html/sanitize_html.dart';
import 'package:spicyguitaracademy/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class Student {
  static String id;
  static String firstname;
  static String lastname;
  static String email;
  static String telephone;
  static String avatar;
  static String status;
  static bool isNewStudent;
  static bool forgotPassword;

  static bool subscription;
  static int daysRemaining;
  static String subscriptionPlan;

  static int studyingCategory;
  static String studyingCategoryLabel;
  static int takenCourses;
  static int allCourses;
  static int takenLessons;
  static int allLessons;

  static bool hasUnreadNotifications;
  static String subscriptionPlanLabel;

  static bool isLoaded = false;

  static pseudoSignin({bool handleClick = false}) async {
    try {
      // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      // print(prefs.getBool('authenticated'));
      Auth.authenticated = prefs.getBool('authenticated') ?? false;
      if (Auth.authenticated == true) {
        id = prefs.getString('id');
        firstname = prefs.getString('firstname');
        lastname = prefs.getString('lastname');
        email = prefs.getString('email');
        telephone = prefs.getString('telephone');
        avatar = prefs.getString('avatar');
        status = prefs.getString('status');
        Auth.token = prefs.getString('token');
        isNewStudent = false;
        forgotPassword = false;

        if (handleClick == true) {
          // load subscription plans
          await Subscription.getSubscriptionPlans();

          // get student subscription status, days remaining and subscription plan
          await getSubscriptionStatus();

          // get the current category and stats
          await getStudentCategoryAndStats();
        }

        // print(prefs.getBool('authenticated'));
      }
    } catch (e) {
      throw (e);
    }
  }

  static cacheSignin() async {
    // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // store redundant values in sharedpreference
    final SharedPreferences prefs = await _prefs;
    prefs.setString('id', id);
    prefs.setString('firstname', firstname);
    prefs.setString('lastname', lastname);
    prefs.setString('email', email);
    prefs.setString('telephone', telephone);
    prefs.setString('avatar', avatar);
    prefs.setString('status', status);
    prefs.setString('token', Auth.token);
    prefs.setBool('authenticated', Auth.authenticated);

    print(prefs.getBool('authenticated'));
  }

  static clearSigninCache() async {
    // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // store redundant values in sharedpreference
    final SharedPreferences prefs = await _prefs;
    prefs.remove('firstname');
    prefs.remove('lastname');
    prefs.remove('email');
    prefs.remove('telephone');
    prefs.remove('avatar');
    prefs.remove('status');
    prefs.remove('token');
    prefs.setBool('authenticated', false);

    print(prefs.getBool('authenticated'));
  }

  static signin(Map<String, dynamic> student, String token) async {
    try {
      id = student['id'];
      firstname = student['firstname'];
      lastname = student['lastname'];
      email = student['email'];
      telephone = student['telephone'];
      avatar = student['avatar'];
      status = student['status'];
      isNewStudent = false;
      forgotPassword = false;

      Auth.token = token;
      Auth.authenticated = true;
      await cacheSignin();

      // load subscription plans
      await Subscription.getSubscriptionPlans();

      // get student subscription status, days remaining and subscription plan
      await getSubscriptionStatus();

      // get the current category and stats
      await getStudentCategoryAndStats();
    } catch (e) {
      throw (e);
    }
  }

  static signout() {
    Auth.token = null;
    Auth.authenticated = false;
    id = null;
    firstname = null;
    lastname = null;
    email = null;
    telephone = null;
    avatar = null;
    status = null;
    isNewStudent = null;
    forgotPassword = null;
    subscription = null;
    daysRemaining = null;
    subscriptionPlan = null;
    studyingCategory = null;
    studyingCategoryLabel = null;
    takenCourses = null;
    allCourses = null;
    takenLessons = null;
    allLessons = null;
    hasUnreadNotifications = null;
    subscriptionPlanLabel = null;
    isLoaded = false;

    clearSigninCache();
  }

  static getStudentCategoryAndStats() async {
    try {
      var resp = await request('/api/student/statistics',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      if (resp['status'] == true) {
        studyingCategory = resp['data']['category'] ?? 0;
        takenCourses = resp['data']['takenCourses'] ?? 0;
        allCourses = resp['data']['allCourses'] ?? 0;
        takenLessons = resp['data']['takenLessons'] ?? 0;
        allLessons = resp['data']['allLessons'] ?? 0;
      } else {
        studyingCategory = 0;
        takenCourses = 0;
        allCourses = 0;
        takenLessons = 0;
        allLessons = 0;
      }

      if (subscription == false) studyingCategory = 0;

      studyingCategoryLabel = [
        "No Category",
        "Beginner",
        "Amateur",
        "Intermediate",
        "Advanced"
      ][studyingCategory];
    } catch (e) {
      throw (e);
    }
  }

  static getSubscriptionStatus() async {
    try {
      var resp = await request('/api/subscription/status',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      var data = resp['data'];
      subscription = data['status'] == 'ACTIVE' ? true : false;
      daysRemaining = data['days'];
      subscriptionPlan = resp['status'] == true ? data['plan'] : '0';

      subscriptionPlanLabel = [
        "No Subscription Plan",
        "1 Month",
        "3 Months",
        "6 Months",
        "12 Months"
      ][int.parse(subscriptionPlan)];
    } catch (e) {
      throw (e);
    }
  }

  static chooseCategory(String category) async {
    try {
      var resp = await request('/api/student/category/select',
          method: 'POST',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          },
          body: {
            'category': category
          });

      if (resp['status'] == true) {
        await getStudentCategoryAndStats();
      }
    } catch (e) {
      throw (e);
    }
  }

  updateProfilePicture() {
    // var request = new http.MultipartRequest("POST", url);
    // request.fields['user'] = 'someone@somewhere.com';
    // request.files.add(http.MultipartFile.fromPath(
    //     'package',
    //     'build/package.tar.gz',
    //     contentType: new MediaType('application', 'x-tar'),
    // ));
    // request.send().then((response) {
    //   if (response.statusCode == 200) print("Uploaded!");
    // });
  }
}

class Auth {
  static String token;
  static bool authenticated;
}

class Subscription {
  static String reference;
  static String accessCode;
  static int price;
  static bool paystatus;
  static bool featuredpaystatus;
  static List<dynamic> plans;

  static getSubscriptionPlans() async {
    try {
      var resp = await request('/api/subscription/plans',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });
      plans = resp['data'];
    } catch (e) {
      throw (e);
    }
  }

  static initiateFeaturedPayment(courseId) async {
    try {
      var resp = await request(
        '/api/subscription/initiate-featured',
        method: 'POST',
        body: {'email': Student.email, 'course': courseId.toString()},
        // continue with the server side and
        headers: {
          'JWToken': Auth.token,
          'cache-control': 'max-age=0, must-revalidate'
        },
      );

      // Navigator.pushNamedAndRemoveUntil(context,'/login', (route) => false);
      if (resp['status'] == true) {
        Subscription.reference = resp['data']['reference'];
        Subscription.accessCode = resp['data']['access_code'];
        Subscription.price = resp['data']['price'];
      } else {
        throw Exception(resp['message']);
      }
    } catch (e) {
      throw (e);
    }
  }

  static initiatePayment(selectedPlan) async {
    try {
      var resp = await request(
        '/api/subscription/initiate',
        method: 'POST',
        body: {'email': Student.email, 'plan': selectedPlan},
        headers: {
          'JWToken': Auth.token,
          'cache-control': 'max-age=0, must-revalidate'
        },
      );

      if (resp['status'] == true) {
        Subscription.reference = resp['data']['reference'];
        Subscription.accessCode = resp['data']['access_code'];
        Subscription.price = resp['data']['price'];
      } else {
        throw Exception(resp['message']);
      }
    } catch (e) {
      throw (e);
    }
  }

  static verifySubscription() async {
    try {
      var resp = await request(
          '/api/subscription/verify/${Subscription.reference}',
          method: 'POST',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          },
          body: {
            'email': Student.email
          });

      if (resp['status'] == true) {
        Subscription.paystatus = true;
        // get subscription status again
        await Student.getSubscriptionStatus();
      } else {
        Subscription.paystatus = false;
      }
    } catch (e) {
      throw (e);
    }
  }

  static verifyFeatured() async {
    try {
      var resp = await request(
          '/api/subscription/verify-featured/${Subscription.reference}',
          method: 'POST',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          },
          body: {
            'email': Student.email
          });

      if (resp['status'] == true) {
        Subscription.featuredpaystatus = true;
        // get subscription status again
      } else {
        Subscription.featuredpaystatus = false;
      }
    } catch (e) {
      throw (e);
    }
  }
}

List<Course> studyingCourses = [];
List<Course> beginnersCourses = [];
List<Course> amateurCourses = [];
List<Course> intermediateCourses = [];
List<Course> advancedCourses = [];
List<Course> featuredCourses = [];
List<Course> myFeaturedCourses = [];

class Courses {
  static Course currentCourse;
  static String activateCourseErrMsg;

  static getAllCourses(context) async {
    try {
      var resp = await request('/api/student/courses/all',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      // beginners
      beginnersCourses = [];
      List<dynamic> beginners = resp['data']['beginners'] ?? [];
      beginners.forEach((course) {
        beginnersCourses.add(Course.fromJson(course));
      });
      // amateurs
      amateurCourses = [];
      List<dynamic> amateurs = resp['data']['amateurs'] ?? [];
      amateurs.forEach((course) {
        amateurCourses.add(Course.fromJson(course));
      });
      // intermediates
      intermediateCourses = [];
      List<dynamic> intermediates = resp['data']['intermediates'] ?? [];
      intermediates.forEach((course) {
        intermediateCourses.add(Course.fromJson(course));
      });
      // advanced
      advancedCourses = [];
      List<dynamic> advanced = resp['data']['advanceds'] ?? [];
      advanced.forEach((course) {
        advancedCourses.add(Course.fromJson(course));
      });
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }

  static getStudyingCourses(context) async {
    try {
      var resp = await request('/api/student/courses/studying',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });
      List<dynamic> courses = resp['data'] ?? [];
      studyingCourses = [];
      courses.forEach((course) {
        studyingCourses.add(Course.fromJson(course));
      });
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }

  static activateCourse(context) async {
    try {
      activateCourseErrMsg = "";
      var resp = await request('/api/student/course/activate',
          method: 'POST',
          body: {
            'course': Courses.currentCourse.id.toString()
          },
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      if (resp['status'] == true) {
        Courses.currentCourse.status = true;
        studyingCourses[studyingCourses.indexOf(Courses.currentCourse)] =
            Courses.currentCourse;
      } else {
        // activateCourseErrMsg =
        if (resp['message'] != "Course already activated") {
          snackbar(context, resp['message']);
        }
      }
    } on AuthException catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
    } catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
    }
  }

  static getAllFeaturedCourses(context) async {
    try {
      var resp = await request('/api/student/featuredcourses/all',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      List<dynamic> courses = resp['data'] ?? [];
      featuredCourses = [];
      courses.forEach((course) {
        featuredCourses.add(Course.fromJson(course));
      });
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }

  static getMyFeaturedCourses(context) async {
    try {
      var resp = await request('/api/student/featuredcourses/bought',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });
      List<dynamic> courses = resp['data'] ?? [];
      myFeaturedCourses = [];
      courses.forEach((course) {
        myFeaturedCourses.add(Course.fromJson(course));
      });
    } on AuthException catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
    } catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
    }
  }

  static sortByTutor(courses) {
    return courses
        .sort((a, b) => a.tutor.toString().compareTo(b.tutor.toString()));
  }

  static sortByTitle(courses) {
    return courses
        .sort((a, b) => a.title.toString().compareTo(stripExceptions(b.title)));
  }

  static sortByOrder(courses) {
    return courses
        .sort((a, b) => a.order.toString().compareTo(b.order.toString()));
  }

  static getAssigment(context, courseId) async {
    try {
      var resp = await request('/api/course/$courseId/assignment',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });
      if (resp['status'] == true) {
        Assignment.status = true;
        Assignment.fromJson(resp['data']);
      } else {
        Assignment.status = false;
      }
    } on AuthException catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }
}

class Course {
  // the properties on the class
  int id;
  int category;
  String title;
  String description;
  String thumbnail;
  String tutor;
  int order;
  int completedLessons;
  int allLessons;
  bool featured;
  double featuredprice;
  String preview;
  bool status;

  // constructing from json
  Course.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']) ?? 0;
    category = int.parse(json['category']) ?? 0;
    title = parseHtmlString(json['course'] ?? 'No title');
    description = parseHtmlString(json['description'] ?? 'No description');
    thumbnail = json['thumbnail'] ?? '';
    tutor = json['tutor'] ?? 'No tutor';
    order = int.parse(json['ord'] ?? '0');
    completedLessons = int.parse(json['done'] ?? '0');
    allLessons = int.parse(json['total'] ?? '0');
    featured = json['featured'] == '1' ? true : false;
    featuredprice = double.parse(json['featuredprice'] ?? 0);
    preview = json['featured_preview_video'] ?? '';
    status = json['status'] ?? false;
  }
}

List<Lesson> courseLessons = [];
List<Lesson> freeLessons = [];

enum LessonSource { featured, normal }

class Lessons {
  static LessonSource source;

  static getFreeLessons(context) async {
    try {
      var resp = await request('/api/student/freelessons',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });
      List<dynamic> lessons = resp['data'] ?? [];
      freeLessons = [];
      lessons.forEach((lesson) {
        freeLessons.add(Lesson.fromJson(lesson));
      });
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }

  static getLessons(context, courseid) async {
    try {
      var resp = await request('/api/course/$courseid/lessons',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });
      List<dynamic> lessons = resp['data'] ?? [];
      courseLessons = [];
      lessons.forEach((lesson) {
        courseLessons.add(Lesson.fromJson(lesson));
      });
    } on AuthException catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
    } catch (e) {
      // print(e.toString());
      // if loading is active and this method is called, error won't take effect
      throw (e);
      // error(context, stripExceptions(e));
    }
  }

  static getFeaturedLessons(context, courseid) async {
    try {
      var resp = await request('/api/course/featured/$courseid/lessons',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });
      List<dynamic> lessons = resp['data'] ?? [];
      courseLessons = [];
      lessons.forEach((lesson) {
        courseLessons.add(Lesson.fromJson(lesson));
      });
    } on AuthException catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
    } catch (e) {
      // print(e.toString());
      // if loading is active and this method is called, error won't take effect
      throw (e);
      // error(context, stripExceptions(e));
    }
  }

  static activateLesson(context) async {
    try {
      var resp = await request('/api/student/lesson/activate',
          method: 'POST',
          body: {
            'lesson': currentTutorial.id.toString()
          },
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      if (resp['status'] == true) {
        // update the number of lessons taken in the stats
        Student.takenLessons++;
        // update the number of lessons taken for the current course
        Courses.currentCourse.completedLessons++;
        studyingCourses[studyingCourses.indexOf(Courses.currentCourse)] =
            Courses.currentCourse;
        // if all lessons for this course has been taken, update the nuber of course completed for this student
        if (Courses.currentCourse.allLessons ==
            Courses.currentCourse.completedLessons) {
          Student.takenCourses++;
        }
      }
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }

  static activateFeaturedLesson(context) async {
    try {
      var resp = await request('/api/student/lesson/activate-featured',
          method: 'POST',
          body: {
            'lesson': currentTutorial.id.toString()
          },
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      if (resp['status'] == true) {
        // update the number of lessons taken for the current course
        Courses.currentCourse.completedLessons++;
        myFeaturedCourses[myFeaturedCourses.indexOf(Courses.currentCourse)] =
            Courses.currentCourse;
      }
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }
}

class Lesson {
  // the properties on the class
  int id;
  int courseId;
  String title;
  String description;
  int order;
  String thumbnail;
  String tutor;
  String video;
  String audio;
  String practice;
  String tablature;
  String note;

  Lesson();

  // constructing from json
  Lesson.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']) ?? 0;
    courseId = int.parse(json['course']) ?? 0;
    title = parseHtmlString(json['lesson'] ?? 'No title');
    description = parseHtmlString(json['description'] ?? 'No description');
    order = int.parse(json['ord']) ?? 0;
    thumbnail = json['thumbnail'];
    tutor = json['tutor'] ?? 'No tutor';
    video = json['high_video'] ?? null;
    audio = json['audio'] ?? null;
    practice = json['practice_audio'] ?? null;
    tablature = json['tablature'] ?? null;
    note = json['note'] ?? null;
    note = note != null ? parseHtmlString(note) : note;
  }
}

// the list of lessons in a tutorial used for moving forward and backward in the tutorial
List<Lesson> tutorialLessons = [];
// the current tutorial which is gotten from the lesson object
Lesson currentTutorial;

class Tutorial {
  static List<dynamic> comments;

  static getTutorialComments(context) async {
    try {
      var resp = await request('/api/lesson/${currentTutorial.id}/comments',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=0, must-revalidate'
          });

      return resp['data'] ?? [];
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }

  static submitComment(context, comment, id, tutor) async {
    try {
      var resp = await request('/api/commentlesson', method: 'POST', body: {
        'comment': comment,
        'lessonId': id.toString(),
        'receiver': tutor
      }, headers: {
        'JWToken': Auth.token,
        'cache-control': 'max-age=0, must-revalidate'
      });

      return resp['status'] ?? false;
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
    }
  }
}

class Assignment {
  static int id;
  static int answerId;
  static String questionNote;
  static String questionVideo;
  static String tutor;
  static int tutorId;
  static String answerNote;
  static String answerVideo;
  static int answerRating;
  static String answerReview;
  static DateTime answerDate;
  static bool status;

  Assignment.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']) ?? 0;
    tutorId = int.parse(json['tutor_id']) ?? 0;
    answerId = int.parse(json['answerId']) ?? 0;
    tutor = json['tutor'] ?? 'No tutor';
    questionNote = json['questionNote'] ?? null;
    questionNote =
        questionNote != null ? parseHtmlString(questionNote) : questionNote;
    questionVideo =
        json['questionVideo'] == "NULL" ? null : json['questionVideo'] ?? null;
    answerNote = json['answerNote'] ?? null;
    answerNote = answerNote != null ? parseHtmlString(answerNote) : answerNote;
    answerRating = int.parse(json['rating']) ?? 0;
    answerReview = json['review'] ?? null;
    answerVideo = json['answerVideo'] ?? null;
    answerDate = DateTime.parse(json['answerDate']) ?? null;
  }

  static submitAnswer(context, answer) async {
    try {
      await request('/api/student/assignment/answer', method: 'POST', body: {
        'note': answer,
        'answerId': Assignment.answerId.toString(),
        'assignment': Assignment.id.toString()
      }, headers: {
        'JWToken': Auth.token,
        'cache-control': 'max-age=0, must-revalidate'
      });
    } on AuthException catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
    } catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
    }
  }

  static uploadAnswer() {}
}

class Forum {
  static List<dynamic> comments;

  static getForumMessages(context) async {
    try {
      var resp = await request(
          '/api/forums/${Student.studyingCategory}/messages',
          method: 'GET',
          headers: {
            'JWToken': Auth.token,
            'cache-control': 'max-age=6400000, must-revalidate'
          });

      return resp['data'] ?? [];
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      // error(context, stripExceptions(e));
      throw (e);
    }
  }

  static submitMessage(context, comment, replyId) async {
    try {
      var resp = await request('/api/forum/message', method: 'POST', body: {
        'comment': comment,
        'categoryId': Student.studyingCategory.toString(),
        'replyId': replyId
      }, headers: {
        'JWToken': Auth.token,
        'cache-control': 'max-age=0, must-revalidate'
      });

      return resp['status'] ?? false;
    } on AuthException catch (e) {
      // error(context, stripExceptions(e));
      // reAuthenticate(context);
      throw (e);
    } catch (e) {
      throw (e);
      // error(context, stripExceptions(e));
    }
  }
}
