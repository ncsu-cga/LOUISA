import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

import 'package:louisa_demo/utils/style.dart';
import 'package:louisa_demo/ui/ui_question_text.dart';
import 'package:louisa_demo/widgets/ui_rounded_button.dart';
import 'package:louisa_demo/utils/constant.dart';
// Screen
import 'package:louisa_demo/screens/surveys/onetime/survey_doctor_info_screen.dart';
import 'package:louisa_demo/utils/utils.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';

import 'package:louisa_demo/services/shared_preferences.dart';
import 'package:louisa_demo/screens/surveys/onetime/profile_widgets/material_datepicker.dart';
import 'package:louisa_demo/screens/surveys/onetime/profile_widgets/cupertino_datepicker.dart';
import 'package:louisa_demo/screens/surveys/onetime/profile_widgets/dialog_age_lessthan.dart';
import 'package:louisa_demo/screens/surveys/onetime/profile_widgets/map_current_loc.dart';
import 'package:louisa_demo/screens/surveys/onetime/profile_widgets/address.dart';

class PaticipantInfoScreen2 extends StatefulWidget {
  static const id = 'paticipant_info_screen2';
  @override
  _PaticipantInfoScreen2State createState() => _PaticipantInfoScreen2State();
}

class _PaticipantInfoScreen2State extends State<PaticipantInfoScreen2> {
  // Permission _permission;
  // PermissionStatus _permissionStatus;
  static const double sizedBoxHeight = 40.0;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  TextEditingController _streetAdressController;
  TextEditingController _cityController;
  TextEditingController _parishController;
  TextEditingController _stateController;
  TextEditingController _zipCodeController;
  final _birthday = TextEditingController();
  final _phone = TextEditingController();
  HomeLocation _homeLoc;
  bool mapVisible = false;
  bool addressVisible = false;
  MapController _mapController = MapController();
  LatLng _center = LatLng(51.5, -0.09);

  @override
  void initState() {
    super.initState();
    //getCurrentLocation();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _streetAdressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _parishController.dispose();
    _zipCodeController.dispose();
    _birthday.dispose();
    _phone.dispose();
    super.dispose();
  }

  Widget getDatePicker() {
    if (Platform.isIOS) {
      return IosDatePicker('Birthday', _birthday);
    }
    return MaterialDatePicker('Birthday', _birthday);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'One-time Survey'),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              QuestionText('What is your name?'),
              TextFormField(
                style: defaultText,
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
                  // This optional bl6                   ock of code can be used to run
                  // code when the unser saves the form.
                },
                validator: (String value) {
                  return value.isEmpty ? 'First name is required' : null;
                },
              ),
              TextFormField(
                style: defaultText,
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
              ListTile(
                title: Text(
                  'Use current location.',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                leading: Radio(
                  value: HomeLocation.MOBILE_LOCATION,
                  groupValue: _homeLoc,
                  onChanged: (HomeLocation value) async {
                    _center = await getCurrentLocation();
                    setState(() {
                      _homeLoc = value;
                      mapVisible = true;
                      addressVisible = false;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Enter my home address.',
                    style: TextStyle(fontSize: 18.0)),
                leading: Radio(
                  value: HomeLocation.ENTER_ADDRESS,
                  groupValue: _homeLoc,
                  onChanged: (HomeLocation value) {
                    setState(() {
                      print(value);
                      _homeLoc = value;
                      mapVisible = false;
                      addressVisible = true;
                    });
                  },
                ),
              ),
              // SizedBox(height: sizedBoxHeight),
              Visibility(
                visible: mapVisible,
                child: MapCurrentLocation(_center, _mapController),
              ),
              Visibility(
                  visible: addressVisible,
                  child: AddressForm(_streetAdressController, _cityController,
                      _parishController, _stateController, _zipCodeController)),
              SizedBox(height: sizedBoxHeight),
              QuestionText('What is your date of birth?'),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: getDatePicker(),
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
                  if (value.isEmpty) return 'Phone number is required.';
                  if (!isValidPhoneNumber(value))
                    return 'Invalid phone number.';
                  else
                    _phone.text = value;
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
                  int age = calculateAge(_birthday.text);

                  if (age < 18) {
                    print(age);
                    ageYangerThan18Dialog(context, Const.AGE_YANGER_TITLE,
                        Const.AGE_YANGER_CONTENT);
                  } else {
                    setSharedPreference(Const.PROFILE, Const.COMPLETE);
                    Navigator.popAndPushNamed(context, DoctorInfoScreen.id);
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
