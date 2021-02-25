import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:research_package/research_package.dart';

import 'package:louisa_demo/utils/style.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    throw "Could not launch $url";
  }
}

Widget call911Dialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      'Call 911?',
      textAlign: TextAlign.center,
    ),
    content: RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text:
                  '(if yes to chest pain, heart palpitations, or difficulty breathing) You should ',
              style: dialogText),
          TextSpan(
              text: 'call 911',
              style: urlLinkText,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl('tel:' + Const.CALL_911);
                  blocTask.sendStatus(StepStatus.Finished);
                }),
          TextSpan(text: ' right away.', style: dialogText)
        ],
      ),
    ),
    actions: [
      TextButton(
        child: const Text('CANCEL'),
        onPressed: () {
          blocTask.sendStatus(StepStatus.Finished);
          //Navigator.of(context).pop();
          // Navigator.pushNamed(context, WelcomeScreen.id);
        },
      ),
    ],
  );
}

Widget callDoctorDialog(BuildContext context) {
  return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            String dialogMessage =
                'A medical consultation may be advisable. Would you like ' +
                    'to call ${snapshot.data.getString(Const.DOCTOR_NAME)}?';
            return AlertDialog(
              title: Text(
                'Call Doctor?',
                textAlign: TextAlign.center,
              ),
              content: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: dialogMessage, style: dialogText),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('YES'),
                  onPressed: () async {
                    //Navigator.of(context).pop(ConfirmAction.ACCEPT);
                    launchUrl(
                        'tel:${snapshot.data.getString(Const.DOCTOR_PHONE)}');
                    blocTask.sendStatus(StepStatus.Finished);
                    // Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
                TextButton(
                  child: const Text('NO'),
                  onPressed: () {
                    blocTask.sendStatus(StepStatus.Finished);
                    //Navigator.of(context).pop(ConfirmAction.CANCEL);
                    // Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
              ],
            );
          default:
            return Text("Loading...");
        }
      });
}

