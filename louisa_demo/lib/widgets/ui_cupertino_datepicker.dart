import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IosDatePicker extends StatefulWidget {
  final String title;
  final TextEditingController selectedDateController;
  final String initialDate;
  final String minimumDate;

  IosDatePicker(this.title, this.selectedDateController, this.initialDate,
      this.minimumDate);
  @override
  _IosDatePickerState createState() => _IosDatePickerState();
}

class _IosDatePickerState extends State<IosDatePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime _initialDate = DateFormat.yMd().parse(widget.initialDate);
    DateTime _firstDate = DateFormat.yMd().parse(widget.minimumDate);
    double size = MediaQuery.of(context).size.width;
    DateTime _selectedDate = DateTime.now();
    return TextFormField(
        // style: defaultText,
        controller: widget.selectedDateController,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          labelText: widget.title,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              // title: Text(widget.dialogTitle),
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
                    print(selected);
                    setState(() {
                      _selectedDate = selected;
                    });
                  },
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('DONE'),
                  onPressed: () {
                    widget.selectedDateController.text =
                        DateFormat.yMd().format(_selectedDate);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
