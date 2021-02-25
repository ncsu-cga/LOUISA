import 'package:flutter/material.dart';
import 'package:louisa_demo/utils/style.dart';

class QuestionText extends StatelessWidget {
  QuestionText(this._question);
  final String _question;

  @override
  Widget build(BuildContext context) {
    return Text(
      _question,
      style: questionText,
    );
  }
}

class AnswerTextFormField extends StatelessWidget {
  AnswerTextFormField({
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.autofillHint,
    this.labelText,
    this.validator,
  });
  final TextEditingController controller;
  final String initialValue;
  final TextInputType keyboardType;
  final String labelText;
  final String autofillHint;
  final Function validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.always,
      autofillHints: [autofillHint],
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: validator,
    );
  }
}
