import 'package:flutter/material.dart';
import 'package:louisa_demo/demo.dart';

Future ageYangerThan18Dialog(
    BuildContext context, String title, String content) async {
  return showDialog(
    context: context,
    barrierDismissible: true, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text('CONTIMUE'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('CLOSE'),
            onPressed: () {
              //Navigator.of(context).pop(ConfirmAction.CANCEL);
              Navigator.popAndPushNamed(context, DemoHome.id);
            },
          ),
        ],
      );
    },
  );
}
