import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';

import 'package:louisa_demo/models/dialog_step.dart';
import 'package:louisa_demo/ui/ui_dialog_widgets.dart';

class UIDialogStep extends StatefulWidget {
  final DialogStep step;

  UIDialogStep({this.step});
  @override
  _UIDialogStepState createState() => _UIDialogStepState();
}

class _UIDialogStepState extends State<UIDialogStep> {

  @override
  Widget build(BuildContext context) {
    if (widget.step.dialog == 'CALL_EMERGENCY') {
      return call911Dialog(context);
    }
    if (widget.step.dialog == 'CALL_DOCTOR') {
      return callDoctorDialog(context);
    } else {
      return Text('Something is wrong');
    }
  }
}
