import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/rendering.dart';

import 'package:spicyguitaracademy/pages/public/terms_and_condition.dart';
import 'package:spicyguitaracademy/pages/public/landing_page.dart';
import 'package:spicyguitaracademy/pages/public/welcome_page.dart';
import 'package:spicyguitaracademy/pages/public/register_page.dart';
import 'package:spicyguitaracademy/pages/public/login_page.dart';
import 'package:spicyguitaracademy/pages/user/welcome_note.dart';
import 'package:spicyguitaracademy/pages/user/choose_plan.dart';
// import 'package:spicyguitaracademy/pages/user/paystack_page.dart';
import 'package:spicyguitaracademy/pages/user/successful_transaction.dart';
import 'package:spicyguitaracademy/pages/user/failed_transaction.dart';
import 'package:spicyguitaracademy/pages/user/ready_to_play.dart';
import 'package:spicyguitaracademy/pages/user/start_loading.dart';
import 'package:spicyguitaracademy/pages/user/choose_category.dart';
import 'package:spicyguitaracademy/pages/user/dashboard.dart';
import 'package:spicyguitaracademy/pages/user/search_page.dart';
import 'package:spicyguitaracademy/pages/user/rechoose_plan.dart';
import 'package:spicyguitaracademy/pages/user/rechoose_category.dart';
import 'package:spicyguitaracademy/pages/user/invite_friend.dart';
import 'package:spicyguitaracademy/pages/user/userprofile_page.dart';
import 'package:spicyguitaracademy/pages/user/all_courses_lessons.dart';
import 'package:spicyguitaracademy/pages/user/studying_courses_lessons.dart';
import 'package:spicyguitaracademy/pages/user/quicklesson_video.dart';
import 'package:spicyguitaracademy/pages/user/tutorial_page.dart';
import 'package:spicyguitaracademy/pages/user/assignment_page.dart';
import 'package:spicyguitaracademy/pages/user/tutorial_practice.dart';
import 'package:spicyguitaracademy/services/imgupload.dart';

// import 'services/app.dart';

void main()
{
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //   .then((_) {
      runApp(new MyApp());
    // });
}

class MyApp extends StatelessWidget {

  @override
  Widget build (BuildContext context) {

    // cache
    // precacheImage(AssetImage("assets/imgs/icons/spicy_guitar_logo.png"), context);

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // colors
        primaryColor: Color(0xFF6B2B14),
        // accentColor: Color(0xFF471D0E),
        buttonColor: Color(0xFF6B2B14),

        // brightness
        brightness: Brightness.light,

        cursorColor: Color(0xFF6B2B14),

        focusColor: Color(0xFF6B2B14),

        fontFamily: "Poppins",

        // text themes
        textTheme: TextTheme(

          // headline6: TextStyle(
          //   color: Color(0xFF6B2B14),
          //   fontSize: 20.0
          // ),

          // overline: TextStyle(
          //   color: Color(0xFF6B2B14),
          //   fontSize: 40.0
          // ),

          bodyText2: TextStyle(
            color: Color(0xFF707070),
            fontSize: 16.0,
            fontFamily: 'Poppins'
          )

        ),
        
      ),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LandingPage(), // landing_page
        '/welcome_page': (BuildContext context) => new WelcomePage(),
        '/register_page': (BuildContext context) => new RegisterPage(),
        '/terms_and_condition': (BuildContext context) => new TermsAndCondition(),
        '/login_page': (BuildContext context) => new LoginPage(),
        '/welcome_note': (BuildContext context) => new WelcomeNotePage(),
        '/choose_plan': (BuildContext context) => new ChoosePlan(),
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
        '/tutorial_page': (BuildContext context) => new TutorialPage(),
        '/assignment_page': (BuildContext context) => new AssignmentPage(),
        '/tutorial_practice': (BuildContext context) => new TutorialPractice(),
        '/demo': (BuildContext context) => new UploadImageDemo()
      },
    );
  }
}