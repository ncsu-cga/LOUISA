import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:louisa_demo/utils/constant.dart';

class MaterialDatePicker extends StatefulWidget {
  final String labelText;
  final TextEditingController selectedDateController;
  MaterialDatePicker(this.labelText, this.selectedDateController);

  @override
  _MaterialDatePickerState createState() => _MaterialDatePickerState();
}

class _MaterialDatePickerState extends State<MaterialDatePicker> {
  DateTime _initialDate = DateFormat.yMd().parse(Const.INITIAL_DATE);
  DateTime _firstDate = DateFormat.yMd().parse(Const.MINIMUM_DATE);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.selectedDateController,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      onTap: () async {
        DateTime selectedDate = await showDatePicker(
            context: context,
            initialDate: _initialDate,
            firstDate: _firstDate,
            lastDate: DateTime.now());
        if (selectedDate != null) {
          setState(() {
            widget.selectedDateController.text =
                DateFormat.yMd().format(selectedDate);
          });
        }
      },
    );
  }
}
