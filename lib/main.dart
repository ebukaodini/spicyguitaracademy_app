import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:flutter/rendering.dart';

import 'pages/public/landing_page.dart';
import 'pages/public/welcome_page.dart';
import 'pages/public/register_page.dart';
import 'pages/public/login_page.dart';
import 'pages/user/welcome_note.dart';
import 'pages/user/choose_plan.dart';
// import 'pages/user/paystack_page.dart';
import 'pages/user/successful_transaction.dart';
import 'pages/user/failed_transaction.dart';
import 'pages/user/ready_to_play.dart';
import 'pages/user/start_loading.dart';
import 'pages/user/choose_category.dart';
import 'pages/user/dashboard.dart';
import 'pages/user/search_page.dart';
import 'pages/user/rechoose_plan.dart';
import 'pages/user/rechoose_category.dart';
import 'pages/user/invite_friend.dart';
import 'pages/user/userprofile_page.dart';
import 'pages/user/all_courses_lessons.dart';
import 'pages/user/studying_courses_lessons.dart';
import 'pages/user/quicklesson_video.dart';
// import 'pages/user/tutorial_page.dart';
// import 'pages/user/tutorial_tab.dart';

// import 'services/app.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  
  

  @override
  Widget build (BuildContext context) {

    // cache
    // precacheImage(AssetImage("assets/imgs/icons/spicy_guitar_logo.png"), context);

    return new MaterialApp(
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LandingPage(),// landing_page
        '/welcome_page': (BuildContext context) => new WelcomePage(),
        '/register_page': (BuildContext context) => new RegisterPage(),
        '/login_page': (BuildContext context) => new LoginPage(),
        '/welcome_note': (BuildContext context) => new WelcomeNotePage(),
        '/choose_plan': (BuildContext context) => new ChoosePlan(),
        // '/paystack_page': (BuildContext context) => new Paystack(),
        '/successful_transaction': (BuildContext context) => new SuccessfulTransaction(),
        '/failed_transaction': (BuildContext context) => new FailedTransaction(),
        '/ready_to_play': (BuildContext context) => new ReadyToPlayTransaction(),
        '/start_loading': (BuildContext context) => new StartLoading(),
        '/choose_category': (BuildContext context) => new ChooseCategory(),
        '/dashboard': (BuildContext context) => new Dashboard(),
        '/search_page': (BuildContext context) => new SearchPage(),
        '/rechoose_plan': (BuildContext context) => new ReChoosePlan(),
        '/rechoose_category': (BuildContext context) => new ReChooseCategory(),
        '/invite_friend': (BuildContext context) => new InviteFriend(),
        '/userprofile': (BuildContext context) => new UserProfilePage(),
        '/allcourses_lessons': (BuildContext context) => new AllCoursesLessons(),
        '/studying_courses_lessons': (BuildContext context) => new StudyingCoursesLessons(),
        '/quicklesson_video': (BuildContext context) => new QuickLessonVideo(),
        // '/tutorial_page': (BuildContext context) => new TutorialPage(),
        // '/tutorial_tab': (BuildContext context) => new TutorialTab(),
      },
    );
  }
}