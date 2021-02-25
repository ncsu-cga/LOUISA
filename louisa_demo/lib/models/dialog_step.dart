import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:louisa_demo/ui/ui_dialog_step.dart';

/// A step which can be used to communicate instructions and other information to the participants.
/// Usually it is used as the first step in a Task explaining the task.
class DialogStep extends RPStep {
  String _dialog;
  DialogStep(String identifier, {String dialog}) : super(identifier) {
    this._dialog = dialog;
  }

  String get dialog => this._dialog;

  set dialog(String dialog) {
    this._dialog = dialog;
  }

  /// The widget (UI representation) of the step
  @override
  Widget get stepWidget => UIDialogStep(step: this);
}

enum ConfirmAction { CANCEL, ACCEPT }
