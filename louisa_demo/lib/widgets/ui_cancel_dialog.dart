import 'package:flutter/material.dart';
import 'package:louisa_demo/services/shared_preferences.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/demo.dart';

Future cancelConfirmDialog(BuildContext context,
    {String key, String value}) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Would you like to cancel?'),
        content: const Text(
          'The information  you entered will not be saved.  Would you like to cancel?',
        ),
        actions: [
          TextButton(
            child: const Text('YES'),
            onPressed: () {
              if (key.isNotEmpty && value.isNotEmpty) {
                setSharedPreference(key, value);
              }
              Navigator.of(context).pop(YesNoAction.YES);
              // Navigator.pushNamed(context, PaticipantNavScreen.id);
              //Navigator.pushNamed(context, DemoHome.id);
              Navigator.popUntil(context, ModalRoute.withName(DemoHome.id));
            },
          ),
          TextButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop(YesNoAction.NO);
              //Navigator.pushNamed(context, SignUpScreen.id);
            },
          )
        ],
      );
    },
  );
}
