import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:louisa_demo/utils/style.dart';
import 'package:louisa_demo/ui/ui_question_text.dart';
import 'package:louisa_demo/widgets/ui_rounded_button.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_onetime_screen.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';

class DoctorInfoScreen extends StatefulWidget {
  static const id = 'doctor_info_screen';
  @override
  _DoctorInfoScreenState createState() => _DoctorInfoScreenState();
}

//enum ConfirmAction { YES, NO }

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  YesNoAction _yesNo;

  final _doctorFullName = TextEditingController(text: 'Doctor\'s name');
  final _doctorPhone = TextEditingController(text: '3453456543');
  bool visibility = false;

  void _setDoctorInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Const.DOCTOR_NAME, _doctorFullName.text);
    await prefs.setString(Const.DOCTOR_PHONE, _doctorPhone.text);
  }

  @override
  void dispose() {
    _doctorFullName.dispose();
    _doctorPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'One-time Survey'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisSize: MainAxisSize.min,
            children: [
              QuestionText('Do you have a doctor you see regularly?'),
              ListTile(
                title: Text('Yes'),
                leading: Radio(
                  value: YesNoAction.YES,
                  groupValue: _yesNo,
                  onChanged: (value) {
                    setState(() {
                      _yesNo = value;
                      visibility = true;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('No'),
                leading: Radio(
                  value: YesNoAction.NO,
                  groupValue: _yesNo,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      _yesNo = value;
                      visibility = false;
                    });
                  },
                ),
              ),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: visibility,
                child: Column(
                  children: [
                    Divider(
                      height: 40.0,
                      color: kPrimaryLightColor,
                      thickness: 0.7,
                    ),
                    QuestionText(
                        'What is the name of your primary care doctor?'),
                    TextFormField(
                      controller: _doctorFullName,
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.always,
                      autofocus: true,
                      autofillHints: [AutofillHints.name],
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        // contentPadding: EdgeInsets.all(20),
                        isDense: true,
                        // contentPadding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                      ),
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: null,
                    ),
                    SizedBox(height: 30.0),
                    QuestionText('What is your doctor’s office phone number?'),
                    TextFormField(
                      controller: _doctorPhone,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.always,
                      autofocus: true,
                      autofillHints: [AutofillHints.name],
                      decoration: InputDecoration(
                        labelText: 'Doctor\'s phone number',
                        // contentPadding: EdgeInsets.all(20),
                        isDense: true,
                        // contentPadding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                      ),
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: null,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              // Spacer(),
              RoundedButton(
                title: 'Next',
                color: kPrimaryColor,
                onPressed: () {
                  _setDoctorInfo();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => OneTimeHealthScreen()),
                    ModalRoute.withName('/'),
                  );
                  // Navigator.popAndPushNamed(
                  //     context, OneTimeHealthScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
