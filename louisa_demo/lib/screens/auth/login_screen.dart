import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'package:louisa_demo/screens/surveys/daily/survey_daily_health_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:louisa_demo/screens/auth/sign_up_screen.dart';
import 'package:louisa_demo/utils/style.dart';
import 'package:louisa_demo/widgets/ui_rounded_button.dart';
import 'package:louisa_demo/utils/utils.dart';

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
  SharedPreferences _prefs;
  String demo;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> sharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      demo = _prefs.getString('DEMO');
      print(demo);
    });
  }

  @override
  void initState() {
    super.initState();
    _buildSnackBar();
  }

  Widget snackBar(String message) {
    return SnackBar(
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(message),
      ]),
      duration: Duration(seconds: 10),
      elevation: 8.0,
    );
  }

  _buildSnackBar() async {
    String message;
    await sharedPrefs();

    if (demo == 'ONE_TIME') {
      message = 'Click "I want to paticipate!';
      _scaffoldKey.currentState.showSnackBar(snackBar(message));
    } else if (demo == 'DAILY_HEALTH') {
      message = 'Click "Log In" button';
      _scaffoldKey.currentState.showSnackBar(snackBar(message));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double containerHeight = 90.0;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Log In'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            child: Builder(
              builder: (context) => Form(
                key: _form,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _authError ? _authAlertDialog() : Container(),
                    // SnackBar(content: Text('Message'),),
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DailyHealthScreen()),
                          ModalRoute.withName('/'),
                        );
                        // Navigator.popAndPushNamed(
                        //     context, DailyHealthScreen.id);
                      },
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
