import 'package:intl/intl.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/models/utils.dart';

bool isValidEmail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(email)) ? false : true;
}

// Minimum 1 Upper case
// Minimum 1 lowercase
// Minimum 1 Numeric Number
// Minimum 1 Special Character
// Common Allow Character ( ! @ # $ & * ~ )
// r'^
//   (?=.*[A-Z])       // should contain at least one upper case
//   (?=.*[a-z])       // should contain at least one lower case
//   (?=.*?[0-9])          // should contain at least one digit
//  (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
// $
bool isValidPassword(String password) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(password);
}

bool isValidPhoneNumber(String phone) {
  // Null or empty string is invalid phone number
  if (phone == null || phone.isEmpty) {
    return false;
  }

  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(phone)) {
    return false;
  }
  return true;
}

int calculateAge(String birthday) {
  DateTime today = DateTime.now();
  Duration difference = today.difference(DateFormat.yMd().parse(birthday));
  int age = (difference.inDays / 365).round();
  return age;
}

Future<LatLng> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  print('permission: ${permission}');
  // if (permission == LocationPermission.deniedForever) {
  //   await Geolocator.openLocationSettings();
  //   // return Future.error(
  //   //     'Location permissions are permantly denied, we cannot request permissions.');
  // }

  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission != LocationPermission.whileInUse &&
  //       permission != LocationPermission.always) {
  //     await Geolocator.openLocationSettings();
  //     // return Future.error(
  //     //     'Location permissions are denied (actual value: $permission).');
  //   }
  // }
  Position coordinates = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true);

  // _center = LatLng(coor.latitude, coor.longitude);
  // setState(() {
  //   _mapController.move(_center, 17.0);
  // });
  return LatLng(coordinates.latitude, coordinates.longitude);
}


