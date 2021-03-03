import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:intl/intl.dart';
import 'package:louisa_demo/services/http_services.dart';
// Screen

import 'package:louisa_demo/services/shared_preferences.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
import 'package:louisa_demo/screens/surveys/consent/rp_objects/consent_objects.dart';

class ConsentScreen extends StatefulWidget {
  static const id = 'consent_screen';
  @override
  _ConsentScreenState createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  // String _encode(Object object) =>
  //     const JsonEncoder.withIndent(' ').convert(object);

  void resultCallback(RPTaskResult result, BuildContext context) {
    // Do anything with the result
    //print(_encode(result));
    if (result.results.isEmpty) {
      print('User didn\'t agreed');
      postConsent(null, null, false, context);
      setSharedPreference(Const.CONSENT_FORM, Const.INCOMPLETE);
      Navigator.popAndPushNamed(context, PaticipantNavScreen.id);
    } else {
      // var resultJson = result.toJson();
      setSharedPreference(Const.CONSENT_FORM, Const.COMPLETE);
      final String dateTimeNow =
          DateFormat.yMEd().add_jms().format(DateTime.now());
      setSharedPreference(Const.CONSENT_DATE, dateTimeNow);
      // postConsent(
      //     resultJson['start_date'], resultJson['end_date'], true, context);
      //Navigator.popAndPushNamed(context, PaticipantInfoScreen.id);
    }
  }

  void cancelCallBack() {
    // Do anything with the result at the moment of the cancellation
    print("Cancelled");
    setSharedPreference(Const.CONSENT_FORM, Const.INCOMPLETE);
    //Navigator.of(context).pop();
    //Navigator.popUntil(context, ModalRoute.withName(NonPaticipantNavScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: consentTask,
      onSubmit: (result) {
        resultCallback(result, context);
      },
      onCancel: ([result]) {
        cancelCallBack();
      },
    );
  }
}
