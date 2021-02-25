import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/utils/style.dart';

class IosDatePicker extends StatefulWidget {
  final String title;
  final TextEditingController selectedDateController;
  IosDatePicker(this.title, this.selectedDateController);
  @override
  _IosDatePickerState createState() => _IosDatePickerState();
}

class _IosDatePickerState extends State<IosDatePicker> {
  DateTime _initialDate = DateFormat.yMd().parse(Const.INITIAL_DATE);
  DateTime _firstDate = DateFormat.yMd().parse(Const.MINIMUM_DATE);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return TextFormField(
        style: defaultText,
        controller: widget.selectedDateController,
       textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          labelText: widget.title,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Select your birthday'),
              // contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              content: Container(
                height: 150.0,
                width: size * 0.9,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _initialDate,
                    minimumDate: _firstDate,
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (selected) {
                      widget.selectedDateController.text =
                          DateFormat.yMd().format(selected);
                    }),
              ),
              actions: [
                TextButton(
                  child: const Text('DONE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
