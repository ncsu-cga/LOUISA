import 'package:flutter/foundation.dart';

class PostUser {
  final String email;
  final String password;

  PostUser({
    @required this.email,
    @required this.password,
  });

  PostUser.fromJson(Map<String, dynamic> json) 
      : email = json['email'],
        password = json['password'];

    Map<String, dynamic> toJson() =>
    {
      'email': email,
      'password': password,
    };
}

class PostProfile {
  final String firstName;
  final String lastName;
  final String dob;
  final String phoneNumber;
  final String email;
  final String streetAddress;
  final String city;
  final String parish;
  final String state;
  final String zipCode;

  PostProfile({
    this.firstName,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.email,
    this.streetAddress,
    this.city,
    this.parish,
    this.state,
    this.zipCode,
  });

  factory PostProfile.fromJson(Map<String, dynamic> json) {
    return PostProfile(
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      parish: json['parish'],
      state: json['state'],
      zipCode: json['zipCode'],
    );
  }
}
