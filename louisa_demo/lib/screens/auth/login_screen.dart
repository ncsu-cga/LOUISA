import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:louisa_demo/screens/surveys/daily/survey_daily_health_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:louisa_dev1/constants.dart';
//import 'package:louisa_dev1/screens/my_health_screen.dart';

import 'package:louisa_demo/models/post.dart';
import 'package:louisa_demo/screens/auth/sign_up_screen.dart';
import 'package:louisa_demo/services/http_services.dart';
import 'package:louisa_demo/utils/style.dart';
import 'package:louisa_demo/widgets/ui_rounded_button.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';
import 'package:louisa_demo/utils/utils.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/screens/surveys/consent/survey_consent_screen.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_profile_screen.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_onetime_screen.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';

//https://mundanecode.com/posts/flutter-restapi-login/
//https://github.com/davefaliskie/travel_budget/blob/episode_20/lib/views/sign_up_view.dart
class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _authError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final double containerHeight = 90.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        // height: size.height,
        // width: double.infinity,
        // padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
        child: Container(
          child: Builder(
            builder: (context) => Form(
              key: _form,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _authError ? _authAlertDialog() : Container(),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: containerHeight,
                    child: TextFormField(
                      style: defaultText,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      // onChanged: (value) {
                      //   email = value;
                      // },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) return 'Empty';
                        if (!isValidEmail(_emailController.text))
                          return 'Invalid email';
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: containerHeight,
                    child: TextFormField(
                      style: defaultText,
                      controller: _passwordController,
                      obscureText: true,
                      // onChanged: (value) {
                      //   password = value;
                      // },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) return 'Empty';
                        if (!isValidPassword(val)) return 'Invalid password';
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 40.0,
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.blueAccent,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        // Navigator.popAndPushNamed(context, {page})
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    title: 'Log In',
                    color: kPrimaryColor,
                    onPressed: () {
                      Navigator.popAndPushNamed(context, DailyHealthScreen.id);
                    },
                    // onPressed: () async {
                    // _form.currentState.validate();
                    // var response = await authenticateUser(context,
                    //     _emailController.text, _passwordController.text);
                    // final SharedPreferences pref =
                    //     await SharedPreferences.getInstance();

                    // setState(() {
                    //   if (response.statusCode == 200) {
                    //     _authError = false;
                    //     print('SUCCESS');

                    //     String consent = pref.getString(Const.CONSENT_FORM);
                    //     String profile = pref.getString(Const.PROFILE);
                    //     String onetimeSurvey =
                    //         pref.getString(Const.ONETIME_HEALTH_SURVEY);

                    //     print('Consent: ${consent}');
                    //     print('Profile: ${profile}');
                    //     print('One-time Survey: ${onetimeSurvey}');
                    //     if (consent != Const.COMPLETE) {
                    //       Navigator.popAndPushNamed(
                    //           context, ConsentScreen.id);
                    //     } else if (profile != Const.COMPLETE) {
                    //       Navigator.popAndPushNamed(
                    //           context, PaticipantInfoScreen.id);
                    //     } else if (onetimeSurvey != Const.COMPLETE) {
                    //       Navigator.popAndPushNamed(
                    //           context, OneTimeHealthScreen.id);
                    //     }
                    //   } else {
                    //     _authError = true;
                    //   }
                    // });

                    // print(_form.currentState.validate());
                    // },
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    child: Text(
                      'I want to paticipate!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        // decoration: TextDecoration.underline,
                        color: Colors.blueAccent,
                      ),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, SignUpScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _authAlertDialog() {
  return Container(
    color: Colors.amberAccent,
    width: double.infinity,
    padding: EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                'Incorrect email or password',
                maxLines: 3,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: IconButton(
            //     icon: Icon(Icons.close),
            //     onPressed: () {},
            //   ),
            // ),
          ],
        ),
      ],
    ),
  );
}

enum ConfirmAction { CANCEL, ACCEPT }

Future _ageConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Would you like to participate?'),
        content: const Text(
          'If you are 18 years of age or older and would like to enter '
          'your health information, we will let you know how your symptoms '
          'compare to others in the community as well as informing you about '
          'the environment.',
        ),
        actions: [
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
              Navigator.popAndPushNamed(context, PaticipantNavScreen.id);
            },
          ),
          TextButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
              Navigator.popAndPushNamed(context, SignUpScreen.id);
            },
          )
        ],
      );
    },
  );
}
