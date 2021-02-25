import 'package:flutter/material.dart';
import 'package:louisa_demo/utils/style.dart';
import 'package:louisa_demo/ui/ui_question_text.dart';
import 'package:louisa_demo/widgets/ui_rounded_button.dart';
import 'package:louisa_demo/utils/constant.dart';
// Screen
import 'package:louisa_demo/screens/surveys/onetime/survey_doctor_info_screen.dart';
import 'package:louisa_demo/services/shared_preferences.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';

class PaticipantInfoScreen extends StatefulWidget {
  static const id = 'paticipant_info_screen';
  @override
  _PaticipantInfoScreenState createState() => _PaticipantInfoScreenState();
}

class _PaticipantInfoScreenState extends State<PaticipantInfoScreen> {
  static const double sizedBoxHeight = 40.0;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _streetAdress = TextEditingController();
  final _birthDay = TextEditingController();

  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _streetAdress.dispose();
    _birthDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'One-time Survey'),
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestionText('What is your name?'),
              TextFormField(
                controller: _firstName,
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.always,
                autofocus: true,
                autofillHints: [AutofillHints.name],
                decoration: InputDecoration(
                  labelText: 'First Name',
                  // contentPadding: EdgeInsets.all(20),
                  isDense: true,
                  // contentPadding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'First name is required' : null;
                },
              ),
              TextFormField(
                controller: _lastName,
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'Last name is required' : null;
                },
              ),
              SizedBox(height: sizedBoxHeight),
              QuestionText('What is your address?'),
              TextFormField(
                controller: _streetAdress,
                keyboardType: TextInputType.streetAddress,
                autovalidateMode: AutovalidateMode.always,
                autofillHints: [AutofillHints.streetAddressLine1],
                decoration: InputDecoration(
                  labelText: 'Street Address',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'Street address is required' : null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                autofillHints: [AutofillHints.addressCity],
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  labelText: 'City',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'City is required' : null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.always,
                autofillHints: [AutofillHints.countryName],
                decoration: InputDecoration(
                  labelText: 'Parish',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'Parish is required' : null;
                },
              ),
              TextFormField(
                initialValue: 'Louisiana',
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.always,
                autofillHints: [AutofillHints.addressState],
                decoration: InputDecoration(
                  labelText: 'State',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'State is required' : null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  labelText: 'Zip Code',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'Zip code is required' : null;
                },
              ),
              SizedBox(height: sizedBoxHeight),
              QuestionText('What is your date of birth?'),
              TextFormField(
                controller: _birthDay,
                keyboardType: TextInputType.datetime,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  labelText: 'MM/DD/YYYY',
                ),
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    int strLength = value.length;
                    if (strLength == 2 || strLength == 5) {
                      _birthDay.text = value + '/';
                      _birthDay.selection = TextSelection.fromPosition(
                          TextPosition(offset: _birthDay.text.length));
                    }
                  }
                },
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'Date of birth is required' : null;
                },
              ),
              SizedBox(height: sizedBoxHeight),
              QuestionText('What is your phone number?'),
              TextFormField(
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'Phone number is required' : null;
                },
              ),
              SizedBox(
                height: sizedBoxHeight,
              ),
              QuestionText('What is your email address?'),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'Email address is required' : null;
                },
              ),
              SizedBox(height: 20.0),
              RoundedButton(
                title: 'Next',
                color: kPrimaryColor,
                onPressed: () {
                  // setState(() {});
                  setSharedPreference(Const.PROFILE, Const.COMPLETE);
                  Navigator.popAndPushNamed(context, DoctorInfoScreen.id);
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
