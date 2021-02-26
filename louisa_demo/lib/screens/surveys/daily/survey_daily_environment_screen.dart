import 'package:flutter/material.dart';
import 'package:louisa_demo/demo_screens/demo_take_picture.dart';

import 'package:louisa_demo/screens/surveys/daily/take_picture_screen.dart';

import 'package:louisa_demo/widgets/ui_appbar_widget.dart';
import 'package:louisa_demo/ui/ui_question_text.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/utils/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:louisa_demo/models/choice.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
import 'package:louisa_demo/demo_screens/demo_take_picture.dart';

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
  bool _isHidden = true;
  List<Choice> selectedChoices;
  TextEditingController _zipCodeController;
  TextEditingController _dateOfProblem;
  TextEditingController _timeOfProblem;

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

  Widget _choiceCellBuilder(BuildContext context, int index) {
    return _ChoiceButton(
      choice: choices[index],
      selectedCallBack: _buttonCallBack,
      selected: selectedChoices.contains(choices[index]) ? true : false,
      currentChoices: selectedChoices,
      index: index,
      isLastChoice: index == choices.length - 1,
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  // List<Widget> createChoiceButtons(List<Choice> choices) {
  //   List<Widget> choiceButtons = [];
  //   for (Choice choice in choices) {
  //     var newButton = _ChoiceButton(choice: choice, )
  //   }
  // }

  // List<Widget> createCardListButtons(List<CardButtonItems> items) {
  //   List<Widget> cardButtonItems = [];
  //   for (CardButtonItems item in items) {
  //     var newItem = CardButton(title: item.title, onTap: item.onTap);
  //     cardButtonItems.add(newItem);
  //     cardButtonItems.add(Divider());
  //   }
  //   return cardButtonItems;
  // }

  @override
  Widget build(BuildContext context) {
    void _toggleCheckView() {
      setState(() {
        _isHidden = !_isHidden;
      });
    }

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
                        return value.isEmpty ? 'Zip code is required' : null;
                      },
                    ),
                    TextFormField(
                      controller: _dateOfProblem,
                      keyboardType: TextInputType.datetime,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        labelText: 'MM/DD/YYYY',
                      ),
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          int strLength = value.length;
                          if (strLength == 2 || strLength == 5) {
                            _dateOfProblem.text = value + '/';
                            _dateOfProblem.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _dateOfProblem.text.length));
                          }
                        }
                      },
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Date of problem is required'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: _timeOfProblem,
                      keyboardType: TextInputType.datetime,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        labelText: 'hour:minutes am/pm',
                      ),
                      onChanged: (String value) {},
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Date of problem is required'
                            : null;
                      },
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    if (visibility) {
                      //Navigator.pushNamed(context, TakePictureScreen.id);
                      Navigator.pushNamed(context, DemoTakePictureScreen.id);
                    } else {
                      Navigator.popAndPushNamed(
                          context, PaticipantNavScreen.id);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ChoiceButton extends StatefulWidget {
  final Choice choice;
  final Function selectedCallBack;
  final List<Choice> currentChoices;
  final bool selected;
  final bool isLastChoice;
  final int index;

  _ChoiceButton(
      {this.choice,
      this.selectedCallBack,
      this.currentChoices,
      this.index,
      this.selected,
      this.isLastChoice});
  @override
  __ChoiceButtonState createState() => __ChoiceButtonState();
}

class __ChoiceButtonState extends State<_ChoiceButton> {
  Choice grpChoice;

  Widget checkIcon() {
    return Icon(
      Icons.done,
    );
  }

  @override
  Widget build(BuildContext context) {
    grpChoice = widget.selected ? widget.choice : null;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            onPressed: () => widget.selectedCallBack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Text('Chemical smell inside the home'),
                ),
                Flexible(
                  flex: 1,
                  child: Icon(Icons.done),
                ),

                //   Checkbox(
                //     value: widget.selected,
                //     onChanged: (x) => widget.selectedCallBack(widget.choice),
                //     activeColor: Theme.of(context).primaryColor,
                //   ),
                //   Expanded(
                //     child: Container(
                //       padding: widget.choice.isFreeText
                //           ? null
                //           : EdgeInsets.only(bottom: 13),
                //       decoration: !widget.isLastChoice
                //           ? BoxDecoration(
                //               border: Border(
                //                   bottom: BorderSide(
                //                       color: Theme.of(context).dividerColor)))
                //           : null,
                //     ),
                //   ),
              ],
            ),
          ),
        ),
        // SizedBox(height: 8.0),
      ],
    );
  }
}

// SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//           child: Column(children: [
//             QuestionText(
//                 'Did you notice any odor, smoke, or other problems today?'),
//             ListTile(
//               title: Text('Yes'),
//               leading: Radio(
//                 value: YesNoAction.YES,
//                 groupValue: _yesNo,
//                 onChanged: (value) {
//                   setState(() {
//                     _yesNo = value;
//                     visibility = true;
//                   });
//                 },
//               ),
//             ),
//             ListTile(
//               title: Text('No'),
//               leading: Radio(
//                 value: YesNoAction.NO,
//                 groupValue: _yesNo,
//                 onChanged: (value) {
//                   setState(() {
//                     print(value);
//                     _yesNo = value;
//                     visibility = false;
//                   });
//                 },
//               ),
//             ),
//             Visibility(
//               maintainSize: true,
//               maintainAnimation: true,
//               maintainState: true,
//               visible: visibility,
//               child: Column(children: [
//                 Divider(
//                   height: 40.0,
//                   color: kPrimaryLightColor,
//                   thickness: 0.7,
//                 ),
//                 QuestionText('What kind of problems did you notice?'),
//                 SizedBox(height: 20.0),
//                 Card(
//                   elevation: 0.8,
//                   child: Container(
//                     padding: EdgeInsets.all(4.0),
//                     child: ListView(
//                       shrinkWrap: true,
//                       children: [
//                         Container(
//                           height: 60.0,
//                           margin: EdgeInsets.all(4.0),
//                           padding: EdgeInsets.only(left: 4.0, right: 4.0),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.grey.shade400, // set border color
//                             ),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(8.0)),
//                           ),
//                           child: InkWell(
//                             onTap: () => _toggleCheckView(),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     'Chemical smell inside the home',
//                                     style: TextStyle(fontSize: 17.0),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Align(
//                                       alignment: Alignment.centerRight,
//                                       child:
//                                           Icon(_isHidden ? Icons.done : null)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () => _toggleCheckView(),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 2,
//                                 child: Text('Chemical smell outside the home'),
//                               ),
//                               Expanded(
//                                   flex: 1,
//                                   child: Icon(_isHidden ? Icons.done : null)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ]),
//             ),
//           ]),
//         ),
//       ),
