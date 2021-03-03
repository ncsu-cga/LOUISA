import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:louisa_demo/demo_screens/demo_take_picture.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/utils/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:louisa_demo/models/choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:louisa_demo/widgets/ui_rounded_button.dart';
import 'package:louisa_demo/demo.dart';
import 'package:louisa_demo/widgets/ui_material_datepicker.dart';

List<Choice> choices = [
  Choice.withParams('Chemical smell inside the home', 1),
  Choice.withParams('Chemical smell outside the home', 2),
  Choice.withParams('Chemical spill', 3),
  Choice.withParams('Gas flare', 4),
  Choice.withParams('Smoke inside the home', 5),
  Choice.withParams('Smoke outside the home', 6),
  Choice.withParams('Other', 7),
  Choice.withParams('Not sure', 8)
];

class DailyEnvironmentScreen extends StatefulWidget {
  static const id = 'daily_env_screen';
  @override
  _DailyEnvironmentScreenState createState() => _DailyEnvironmentScreenState();
}

class _DailyEnvironmentScreenState extends State<DailyEnvironmentScreen> {
  YesNoAction _yesNo;
  bool visibility = false;
  List<Choice> selectedChoices;
  TextEditingController _zipCodeController;
  final _dateOfProblem = TextEditingController();
  final _timeOfProblem = TextEditingController();
  final _formKeyEnv = new GlobalKey<FormState>();
  String _initialDate = DateFormat.yMd().format(DateTime.now());

  @override
  void initState() {
    selectedChoices = [];
    super.initState();
  }

  void _buttonCallBack(Choice selectedChoice) {
    if (selectedChoices.contains(selectedChoice)) {
      setState(() {
        selectedChoices.remove(selectedChoice);
      });
    } else {
      setState(() {
        selectedChoices.add(selectedChoice);
      });
    }
    print('You seleceted: $selectedChoices');
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCloseDefault(context, 'Daily Environment Survey'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Did you notice any odor, smoke, or other problems today?',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'What kind of problems did you notice?',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('(Choose one or more options)'),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: choices.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        height: 56.0,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            print(choices[index].text);
                                            _buttonCallBack(choices[index]);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                    choices[index].text,
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: selectedChoices
                                                                .contains(
                                                                    choices[
                                                                        index])
                                                            ? FontWeight.w600
                                                            : FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: selectedChoices
                                                          .contains(
                                                              choices[index])
                                                      ? Icon(Icons.done,
                                                          color: Colors.black)
                                                      : Container(),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                physics: NeverScrollableScrollPhysics(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKeyEnv,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _zipCodeController,
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
                                return value.isEmpty
                                    ? 'Zip code is required'
                                    : null;
                              },
                            ),
                            Container(
                              child: MaterialDatePicker('Date of Problem',
                                  _dateOfProblem, _initialDate, '01/01/2000'),
                            ),
                            Container(
                              child: MaterialTimePicker(
                                  'Time of Problem', _timeOfProblem),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 78.0,
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: RoundedButton(
                      title: 'Submit',
                      color: kPrimaryLightColor,
                      onPressed: () {
                        if (visibility) {
                          if (_formKeyEnv.currentState.validate()) {
                            _formKeyEnv.currentState.save();
                            Navigator.popAndPushNamed(
                                context, DemoTakePictureScreen.id);
                          }
                        } else {
                          Navigator.popUntil(
                              context, ModalRoute.withName(DemoHome.id));
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
