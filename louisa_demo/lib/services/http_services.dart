import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:louisa_demo/screens/surveys/onetime/survey_onetime_screen.dart';
import 'package:louisa_demo/screens/surveys/onetime/survey_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:louisa_demo/screens/surveys/consent/survey_consent_screen.dart';
import 'package:louisa_demo/utils/utils.dart';
import 'package:louisa_demo/utils/constant.dart';

//import 'package:louisa_dev1/screens/consent_screen.dart';
//import 'package:louisa_dev1/screens/my_health_screen.dart';
import 'package:research_package/research_package.dart';

import 'package:louisa_demo/models/post.dart';

class GetHttpResponse {
  final String token;

  GetHttpResponse({
    this.token,
  });

  factory GetHttpResponse.fromJson(Map<String, dynamic> json) {
    return GetHttpResponse(
      token: json['body']['token'],
    );
  }
}

Future<Map> createUser(
    String email, String password, BuildContext context) async {
  final token = 'Dummy';
  final http.Response response = await http.post(
    'http://127.0.0.1:8000/api/user/create/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    // User is created.
    // Navigate to Consent Form page
    //Navigator.pushNamed(context, ConsentScreen.id);
    // Need to return this?
    // Navigato to consent
    print(response.body);
    Navigator.popAndPushNamed(context, ConsentScreen.id);
    //return PostUser.fromJson(jsonDecode(response.body));
    return {Const.AUTH['USER_CREATED']: token};
  } else if (response.statusCode == 400) {
    // User exists
    // TODO recover password
    return {Const.AUTH['NOT_EXISTS']: null};
  } else {
    print(response.statusCode);
    throw Exception('Failed to create user.');
  }
}

Future<http.Response> authenticateUser(
    BuildContext context, String email, String password) async {
  // final SharedPreferences pref = await SharedPreferences.getInstance();

  final http.Response response = await http.post(
    'http://127.0.0.1:8000/api/user/token/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(PostUser(email: email, password: password)),
    // body: jsonEncode(<String, String>{
    //   'email': email,
    //   'password': password,
    // }),
  );
  return response;
  // Map parsed = jsonDecode(response.body);
  // String token;
  // if (response.statusCode == 200) {
  //   token = parsed['token'];
  //   print('token: ${token}');
  //   String consent = pref.getString(Const.CONSENT_FORM);
  //   String profile = pref.getString(Const.PROFILE);
  //   String onetimeSurvey = pref.getString(Const.ONETIME_SURVEY);

  //   if (consent == Const.INCOMPLETE) {
  //     Navigator.popAndPushNamed(context, ConsentScreen.id);
  //   } else if (profile == Const.INCOMPLETE) {
  //     Navigator.popAndPushNamed(context, PaticipantInfoScreen.id);
  //   } else if (onetimeSurvey == Const.INCOMPLETE) {
  //     Navigator.popAndPushNamed(context, OneTimeHealthScreen.id);
  //   }
  // } else {
  //     print(response.body);
  // }

  //   print(response.body);
  //   //return PostUser.fromJson(response.body);
  // } else {
  //   print(response.statusCode);
  //   print(response.body);
  //   //TODO: Urge user to re-enter email and password or forgot password.
  //   throw Exception('Failed to authenticate.');
  // }
}

// Future<http.Response> postConsent(RPTaskResult data) async {
//   //String body = json.encode(data);
//
//   final http.Response response = await http.post(
//       url: 'http://127.0.0.1:8000/api/user/token/',
//       headers: <String, String>{
//         'Content-Type': 'application/json'
//       },
//       body: jsonEncode(<String, dynamic>{
//         'data': data
//       }
//       }));
// }

postConsent(String startDate, String endDate, bool agreement,
    BuildContext context) async {
  final http.Response response = await http.post(
    'http://127.0.0.1:8000/api/survey/consent/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'startDate': startDate,
      'endDate': endDate,
      'agreement': agreement
    }),
  );

  if (response.statusCode == 200) {
//    Navigator.pushNamed(context, MyHealthScreen.id);
  } else {
    throw Exception('Failed to load post');
  }
}

postUserProfile() {}
// postConsent(RPTaskResult data, BuildContext context) async {
//   final http.Response response = await http.post(
//     'http://127.0.0.1:8000/api/survey/consent/',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{'data': data}),
//   );
//
//   if (response.statusCode == 200) {
//     Navigator.pushNamed(context, MyHealthScreen.id);
//   } else {
//     throw Exception('Failed to load post');
//   }
// }
