import 'package:flutter/material.dart';
import 'package:louisa_demo/screens/surveys/daily/survey_daily_environment_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:louisa_demo/widgets/ui_home_card_button.dart';
import 'package:louisa_demo/screens/auth/login_screen.dart';

class PaticipantHomeScreen extends StatefulWidget {
  static const id = 'paticipant_home_screen';

  @override
  _PaticipantHomeScreenState createState() => _PaticipantHomeScreenState();
}

class _PaticipantHomeScreenState extends State<PaticipantHomeScreen> {
  String token = 'logged_in';
  bool consent = false;
  SharedPreferences _prefs;
  String demo;

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  Future<void> sharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      demo = _prefs.getString('DEMO');
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: [
              Text(
                "Thank you for visiting! Learn how air pollution affects your health.  Report an air quality problem. ",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: ListView(children: [
                  CardButton(
                      title: 'My Health Symptom',
                      leading: demo != 'DAILY_ENVIRONMENT'
                          ? Icon(Icons.emoji_people,
                              size: 46.0, color: Colors.pinkAccent)
                          : Icon(Icons.emoji_people, size: 36.0),
                      onTap: () => demo != 'DAILY_ENVIRONMENT'
                          ? Navigator.pushNamed(context, LoginScreen.id)
                          : null),
                  CardButton(
                    title: 'My Community Health',
                    leading: Icon(Icons.construction_sharp, size: 30.0),
                    onTap: null,
                  ),
                  CardButton(
                    title: 'My Local Air Quality',
                    leading: Icon(Icons.construction_sharp, size: 30.0),
                    onTap: null,
                  ),
                  CardButton(
                    title: 'Report an Environmental Problem',
                    leading: demo == 'DAILY_ENVIRONMENT'
                        ? Icon(Icons.whatshot_outlined,
                            size: 46.0, color: Colors.deepPurpleAccent)
                        : Icon(Icons.whatshot_outlined, size: 36.0),
                    onTap: () => demo == 'DAILY_ENVIRONMENT'
                        ? Navigator.pushNamed(
                            context, DailyEnvironmentScreen.id)
                        : null,
                  ),
                  CardButton(
                    title: 'Read Other Air Pollution problem',
                    leading: Icon(Icons.construction_sharp, size: 30.0),
                    onTap: null,
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
