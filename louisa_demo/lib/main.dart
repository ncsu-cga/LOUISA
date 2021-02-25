import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:research_package/research_package.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
import 'package:louisa_demo/screens/surveys/consent/survey_consent_screen.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_doctor_info_screen.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_onetime_screen.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_profile_screen.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_profile_screen2.dart';
import 'package:louisa_demo/screens/surveys/daily/survey_daily_environment_screen.dart';
import 'package:louisa_demo/screens/surveys/daily/survey_daily_health_screen.dart';
import 'package:louisa_demo/screens/surveys/daily/take_picture_screen.dart';
import 'package:louisa_demo/screens/auth/login_screen.dart';
import 'package:louisa_demo/screens/auth/sign_up_screen.dart';
import 'package:louisa_demo/screens/local_notification_screen.dart';
import 'package:louisa_demo/demo.dart';
import 'package:louisa_demo/utils/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    clearSharedPreferences();
    return MaterialApp(
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        // A class which loads the translations from JSON files
        RPLocalizations.delegate,
        // Built-in localization of basic text for Cupertino widgets
        GlobalCupertinoLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode
              /*  && supportedLocale.countryCode == locale.countryCode */
              // TODO: Test on physical iPhone if Locale should use countryCode instead
              ) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: PaticipantNavScreen.id,
      routes: {
        DemoHome.id: (context) => DemoHome(),
        LocalNotificationScreen.id: (context) => LocalNotificationScreen(),
        //NonPaticipantNavScreen.id: (context) => NonPaticipantNavScreen(),
        PaticipantNavScreen.id: (context) => PaticipantNavScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ConsentScreen.id: (context) => ConsentScreen(),
        PaticipantInfoScreen.id: (context) => PaticipantInfoScreen(),
        PaticipantInfoScreen2.id: (context) => PaticipantInfoScreen2(),
        DoctorInfoScreen.id: (context) => DoctorInfoScreen(),
        OneTimeHealthScreen.id: (context) => OneTimeHealthScreen(),
        DailyHealthScreen.id: (context) => DailyHealthScreen(),
        DailyEnvironmentScreen.id: (context) => DailyEnvironmentScreen(),
        TakePictureScreen.id: (context) => TakePictureScreen(),
      },
    );
  }
}
