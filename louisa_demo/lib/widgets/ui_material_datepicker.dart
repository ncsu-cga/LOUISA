import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaterialDatePicker extends StatefulWidget {
  final String labelText;
  final TextEditingController selectedDateController;
  final String initialDate;
  final String minimumDate;
  
  MaterialDatePicker(this.labelText, this.selectedDateController,
      this.initialDate, this.minimumDate);

  @override
  _MaterialDatePickerState createState() => _MaterialDatePickerState();
}

class _MaterialDatePickerState extends State<MaterialDatePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime _initialDate = DateFormat.yMd().parse(widget.initialDate);
    DateTime _firstDate = DateFormat.yMd().parse(widget.minimumDate);
    return TextFormField(
      controller: widget.selectedDateController,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      validator: (String value) {
        return value.isEmpty ? 'Day is required' : null;
      },
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

class MaterialTimePicker extends StatefulWidget {
  final String labelText;
  final TextEditingController selectedTimeController;

  MaterialTimePicker(this.labelText, this.selectedTimeController);
  @override
  _MaterialTimePickerState createState() => _MaterialTimePickerState();
}

class _MaterialTimePickerState extends State<MaterialTimePicker> {
  // TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        widget.selectedTimeController.text =
            '${selectedTime.hour}:${selectedTime.minute}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.selectedTimeController,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
      validator: (String value) {
        return value.isEmpty ? 'Time is required' : null;
      },
      onTap: () {
        _selectTime(context);
      },
    );
  }
}
