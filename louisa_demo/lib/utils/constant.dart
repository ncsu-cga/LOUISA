class Const {
  // Auth
  static const String SESSION = '';

  // Survey
  static const String CALL_911 = '';
  static const String DOCTOR_NAME = '';
  static const String DOCTOR_PHONE = '';
  static const String CONSENT_FORM = '';
  static const String CONSENT_DATE = '';
  static const String PROFILE = '';
  static const String ONETIME_HEALTH_SURVEY = '';
  static const String ONETIME_HEALTH_SURVEY_DATE = '';

  //static const String DATE_FORMAT = 'MM/DD/yyyy';
  static const String INITIAL_DATE = '1/1/1960';
  static const String MINIMUM_DATE = '1/1/1890';

  // Dialogs
  static const String AGE_YANGER_TITLE = 'You are yanger than 18 years old';
  static const String AGE_YANGER_CONTENT =
      'We are sorry, but you must be at least 18 years old to use this app.';

  // Geolocation
  static const double ZOOM = 17.0;
  static const String INCOMPLETE = 'INCOMPLETE';
  static const String COMPLETE = 'COMPLETE';
  static const Map<String, String> AUTH = {
    'USER_CREATED': 'USER_CREATED',
    'USER_EXISTS': 'USER_EXISTS',
    'USER_NOT_EXISTS': 'USER_NOT_EXISTS',
  };

  // Notification
  static const int HOUR = 10;
  static const String DAILY_NOTIFICATION_TITLE = 'LOUISA Daily Health Survey';
  static const String DAILY_NOTIFICATION_CONTENTS =
      'Let us know how you feel today. If air quality is borthing you, don\'t forget to report.';

  // LDEQ complaint website
  static const LDEQ_COMPLAINT_URL =
      'https://internet.deq.louisiana.gov/portal/ONLINESERVICES/FORMS/FILE-A-CITIZEN-COMPLAINT';
}

enum ConfirmAction { CANCEL, ACCEPT }
enum Completion { COMPLETE, INCOMPLETE }
enum YesNoAction { YES, NO }
enum HomeLocation { MOBILE_LOCATION, ENTER_ADDRESS }
