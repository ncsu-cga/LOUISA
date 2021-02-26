import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:research_package/research_package.dart';
import 'package:louisa_demo/screens/surveys/onetime/rp_objects/onetime_objects.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
import 'package:louisa_demo/services/shared_preferences.dart';
import 'package:louisa_demo/utils/constant.dart';

class OneTimeHealthScreen extends StatelessWidget {
  static const id = 'one_time_health_screen';
  String _encode(Object object) =>
      const JsonEncoder.withIndent(' ').convert(object);

  void resultCallback(RPTaskResult result) {
    // Do anything with the result
    final String dateTimeNow =
        DateFormat.yMEd().add_jms().format(DateTime.now());
    setSharedPreference(Const.ONETIME_HEALTH_SURVEY, Const.COMPLETE);
    setSharedPreference(Const.ONETIME_HEALTH_SURVEY_DATE, dateTimeNow);
    print(_encode(result));
  }

  void cancelCallBack(BuildContext context, RPTaskResult result) {
    // Do anything with the result at the moment of the cancellation
    //print('The result so far:\n' + _encode(result));
    setSharedPreference(Const.ONETIME_HEALTH_SURVEY, Const.INCOMPLETE);
    Navigator.popAndPushNamed(context, PaticipantNavScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: navigableSurveyTask,
      onSubmit: (result) {
        resultCallback(result);
      },
      onCancel: ([result]) {
        cancelCallBack(context, result);
      },
    );
  }
}

// class OneTimeHealthScreen extends StatelessWidget {
//   static const id = 'one_time_health_screen';

//   String _encode(Object object) =>
//       const JsonEncoder.withIndent(' ').convert(object);

//   RPOrderedTask createTasks(RPTaskResult result) {
//     // Do anything with the resultList
//   void resultCallback(RPTaskResult result) {
//     // Do anything with the result
//     print(_encode(result));
//   }

//   void cancelCallBack(RPTaskResult result) {
//     // Do anything with the result at the moment of the cancellation
//     print('The result so far:\n' + _encode(result));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RPUITask(
//       task: navigableSurveyTask,
//       onSubmit: (result) {
//         resultCallback(result);
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => OneTimeHealthScreen2(result)),
//         // );
//       },
//       onCancel: ([result]) {
//         cancelCallBack(result);
//       },
//     );
//   }
// }
