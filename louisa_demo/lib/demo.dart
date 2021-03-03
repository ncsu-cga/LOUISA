import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:louisa_demo/widgets/ui_home_card_button.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';

class DemoHome extends StatefulWidget {
  static const id = 'demo_home_screen';
  @override
  _DemoHomeState createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  List<Widget> createCardListButtons(List<CardButton> items) {
    List<Widget> cardButtonItems = [];
    for (CardButton item in items) {
      var newItem = CardButton(title: item.title, onTap: item.onTap);
      cardButtonItems.add(newItem);
      cardButtonItems.add(Divider());
    }
    return cardButtonItems;
  }

  void _setFirstTimeInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('DEMO', 'ONE_TIME');
    await prefs.setString(Const.CONSENT_FORM, '');
    await prefs.setString(Const.PROFILE, '');
    await prefs.setString(Const.ONETIME_HEALTH_SURVEY, '');
  }

  void _setDailyInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('DEMO', 'DAILY_HEALTH');
    await prefs.setString(Const.CONSENT_FORM, Const.COMPLETE);
    await prefs.setString(Const.PROFILE, Const.COMPLETE);
    await prefs.setString(Const.ONETIME_HEALTH_SURVEY, Const.COMPLETE);
  }

  void _setAnonymousInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('DEMO', 'DAILY_ENVIRONMENT');
    await prefs.setString(Const.CONSENT_FORM, '');
    await prefs.setString(Const.PROFILE, '');
    await prefs.setString(Const.ONETIME_HEALTH_SURVEY, '');
  }

  @override
  Widget build(BuildContext context) {
    List<CardButton> cardButtonItems = [
      CardButton(
          title: 'Onetime Survey',
          onTap: () {
            _setFirstTimeInfo();
            Navigator.pushNamed(context, PaticipantNavScreen.id);
            // Navigator.pushNamed(context, PaticipantNavScreen.id);
          }),
      CardButton(
        title: 'Daily Health Survey',
        onTap: () {
          _setDailyInfo();
          Navigator.pushNamed(context, PaticipantNavScreen.id);
        },
      ),
      CardButton(
        title: 'Daily Environment Survey',
        onTap: () {
          _setAnonymousInfo();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaticipantNavScreen(),
              ));

          // Navigator.pushNamed(context, PaticipantNavScreen.id);
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('LOUISA Demo APP'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
        child: ListView(
          shrinkWrap: true,
          children: createCardListButtons(cardButtonItems),
        ),
      ),
    );
  }
}
