import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF4F3C9E);

const kPrimaryLightColor = Color(0xFF6251A9);

const defaultText = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

const questionText = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

const dialogText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

const urlLinkText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.blueAccent,
  decoration: TextDecoration.underline,
);

const kTextFieldDecoration = InputDecoration(
  // hintText: 'Enter your value',
  // labelText: 'Value',
  // prefixIcon: Icon(
  //   Icons.email,
  //   color: kPrimaryColor,
  // ),
  contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 0.7),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
