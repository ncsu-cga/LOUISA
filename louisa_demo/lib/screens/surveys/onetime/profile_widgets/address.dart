import 'package:flutter/material.dart';

import 'package:louisa_demo/utils/style.dart';

class AddressForm extends StatefulWidget {
  final TextEditingController streetAdressController;
  final TextEditingController cityController;
  final TextEditingController parishController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;
  AddressForm(this.streetAdressController, this.cityController,
      this.parishController, this.stateController, this.zipCodeController);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: defaultText,
          controller: widget.streetAdressController,
          keyboardType: TextInputType.streetAddress,
          autovalidateMode: AutovalidateMode.always,
          autofillHints: [AutofillHints.streetAddressLine1],
          decoration: InputDecoration(
            // contentPadding:
            //     EdgeInsets.symmetric(horizontal: 10.0),
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
          controller: widget.cityController,
          style: defaultText,
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
          controller: widget.parishController,
          style: defaultText,
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
          controller: widget.stateController,
          style: defaultText,
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
          controller: widget.zipCodeController,
          style: defaultText,
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
      ],
    );
  }
}
