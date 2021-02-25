import 'package:flutter/material.dart';
import 'package:louisa_demo/widgets/ui_cancel_dialog.dart';
import 'package:louisa_demo/utils/constant.dart';

Widget appBarWithCloseDefault(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    automaticallyImplyLeading: false,
    elevation: 0.0,
    brightness: Brightness.light,
    actions: [
      IconButton(
        icon: Icon(
          Icons.cancel,
          color: Color(0xff61c3d9),
        ),
        onPressed: () {
          cancelConfirmDialog(context,
              key: Const.PROFILE, value: Const.INCOMPLETE);
          //Navigator.popAndPushNamed(context, NonPaticipantNavScreen.id);
        },
      ),
    ],
  );
}
