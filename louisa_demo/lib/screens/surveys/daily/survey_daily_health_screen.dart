import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:louisa_demo/screens/surveys/daily/rp_objects/daily_objects.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class DailyHealthScreen extends StatelessWidget {
  static const id = "daily_health_screen";
  String _encode(Object object) =>
      const JsonEncoder.withIndent(' ').convert(object);

  void resultCallback(RPTaskResult result) {
    // Do anything with the result
    print(_encode(result));
  }

  void cancelCallBack(RPTaskResult result) {
    // Do anything with the result at the moment of the cancellation
    print("The result so far:\n" + _encode(result));
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: navigableDailyHealthSurveyTask,
      onSubmit: (result) {
        print('pressed');
      },
      onCancel: ([result]) {
        cancelCallBack(result);
      },
    );
  }
}