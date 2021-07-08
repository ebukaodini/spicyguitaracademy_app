import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spicyguitaracademy/pages/authenticated/coursepreview_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/editpassword_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/forums_page.dart';
import 'package:spicyguitaracademy/pages/public/contact.dart';
import 'package:spicyguitaracademy/pages/authenticated/editprofile_page.dart';
import 'package:spicyguitaracademy/pages/public/forgot_password.dart';
import 'package:spicyguitaracademy/pages/public/reset_password.dart';

import 'package:spicyguitaracademy/pages/public/terms_and_condition.dart';
import 'package:spicyguitaracademy/pages/public/landing_page.dart';
import 'package:spicyguitaracademy/pages/public/verify_email.dart';
import 'package:spicyguitaracademy/pages/public/welcome_page.dart';
import 'package:spicyguitaracademy/pages/public/register_page.dart';
import 'package:spicyguitaracademy/pages/public/login_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/welcome_note.dart';

import 'package:spicyguitaracademy/pages/authenticated/choose_plan.dart';
import 'package:spicyguitaracademy/pages/authenticated/successful_transaction.dart';
import 'package:spicyguitaracademy/pages/authenticated/failed_transaction.dart';
import 'package:spicyguitaracademy/pages/authenticated/ready_to_play.dart';
import 'package:spicyguitaracademy/pages/authenticated/start_loading.dart';
import 'package:spicyguitaracademy/pages/authenticated/choose_category.dart';
import 'package:spicyguitaracademy/pages/authenticated/dashboard.dart';
import 'package:spicyguitaracademy/pages/authenticated/search_page.dart';
// import 'package:spicyguitaracademy/pages/authenticated/rechoose_plan.dart';
// import 'package:spicyguitaracademy/pages/authenticated/rechoose_category.dart';
import 'package:spicyguitaracademy/pages/authenticated/invite_friend.dart';
import 'package:spicyguitaracademy/pages/authenticated/lessons_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/notifications_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/tutorial_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/settings_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/help_page.dart';
import 'package:spicyguitaracademy/pages/authenticated/assignment_page.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  // .then((_) {});
  runApp(new SpicyGuitarAcademy());
}

class SpicyGuitarAcademy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // cache
    // precacheImage(AssetImage("assets/imgs/icons/spicy_guitar_logo.png"), context);
    // width: DeviceUtil.getScreenWidth(context),
    // height: DeviceUtil.getScreenHeight(context),

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colors
        primaryColor: Color(0xFF6B2B14),
        accentColor: Color(0xFF471D0E),
        // buttonColor: Color(0xFF6B2B14),

        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.auto,

          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),

          errorMaxLines: 3,

          fillColor: Color(0xFF707070),

          hintStyle: TextStyle(color: Color(0xFF707070), fontSize: 20.0),

          //
          labelStyle: TextStyle(color: Color(0xFF707070), fontSize: 20.0),

          // normal
          border: UnderlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF707070)),
          ),

          // focused
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF471D0E)),
          ),

          // errors
          errorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),

        // textButtonTheme: TextButtonThemeData(
        //   style: ButtonStyle(
        //     foregroundColor: brown,
        //   )
        // ),

        primaryColorDark: Color(0xFF471D0E),

        scaffoldBackgroundColor: Color(0xFFF3F3F3),

        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF6B2B14),
          focusColor: Color(0xFF471D0E),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          layoutBehavior: ButtonBarLayoutBehavior.padded,
          splashColor: Color(0xFF471D0E),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Color(0xFF6B2B14))),
        ),

        // brightness
        brightness: Brightness.light,

        // cursorColor: Color(0xFF6B2B14),

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
                fontFamily: 'Poppins')),
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new LandingPage(), // landing_page
        '/welcome_page': (BuildContext context) => new WelcomePage(),
        '/register': (BuildContext context) => new RegisterPage(),
        '/terms_and_condition': (BuildContext context) =>
            new TermsAndCondition(),
        // '/privacy': (BuildContext context) => new PrivacyPolicy(),
        '/login': (BuildContext context) => new LoginPage(),
        '/forgot_password': (BuildContext context) => new ForgotPasswordPage(),
        '/verify': (BuildContext context) => new VerifyPage(),
        '/resetpassword': (BuildContext context) => new ResetPasswordPage(),
        '/welcome_note': (BuildContext context) => new WelcomeNotePage(),
        '/choose_plan': (BuildContext context) => new ChoosePlan(),
        '/successful_transaction': (BuildContext context) =>
            new SuccessfulTransaction(),
        '/failed_transaction': (BuildContext context) =>
            new FailedTransaction(),
        '/ready_to_play': (BuildContext context) =>
            new ReadyToPlayTransaction(),
        '/start_loading': (BuildContext context) => new StartLoading(),
        '/choose_category': (BuildContext context) => new ChooseCategory(),
        '/dashboard': (BuildContext context) => new Dashboard(),
        '/search_page': (BuildContext context) => new SearchPage(),
        // '/rechoose_plan': (BuildContext context) => new ReChoosePlan(),
        // '/rechoose_category': (BuildContext context) => new ReChooseCategory(),
        '/invite_friend': (BuildContext context) => new InviteFriend(),
        '/lessons_page': (BuildContext context) => new LessonsPage(),
        '/tutorial_page': (BuildContext context) => new TutorialPage(),
        '/coursepreview_page': (BuildContext context) =>
            new CoursePreviewPage(),
        '/notification': (BuildContext context) => new NotificationPage(),
        '/help': (BuildContext context) => new HelpPage(),
        '/settings': (BuildContext context) => new SettingsPage(),
        '/forums': (BuildContext context) => new ForumsPage(),
        '/assignment_page': (BuildContext context) => new AssignmentPage(),
        '/contactus': (BuildContext context) => new ContactUsPage(),
        '/editprofile': (BuildContext context) => new EditProfilePage(),
        '/editpassword': (BuildContext context) => new EditPasswordPage(),
      },
    );
  }
}
