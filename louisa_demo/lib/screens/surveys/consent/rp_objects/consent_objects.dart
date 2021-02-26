import 'package:louisa_demo/screens/surveys/onetime/survey_profile_screen2.dart';
import 'package:research_package/model.dart';

import 'package:louisa_demo/screens/surveys/onetime/survey_profile_screen.dart';

RPConsentSection titleSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'COLFAX/LOUISIANA MOBILE PHONE APP CONSENT FORM '
  ..summary = ''
  ..content =
      'Louisiana State University Superfund Research Center, Project 3 Hazardous Waste Thermal Treatment and Community Exposure to Environmentally Persistent Free Radicals (EPFRs) (eIRB # XXXXX)';

RPConsentSection piSection =
    RPConsentSection.withParams(RPConsentSectionType.Custom)
      ..title = 'Principal Investigator(s)'
      ..summary = ''
      ..content = 'Jennifer Bryant, jrbryan3@ncsu.edu, (919) 360-1466';

RPConsentSection fundingSrcSection =
    RPConsentSection.withParams(RPConsentSectionType.Custom)
      ..title = 'Funding Source'
      ..summary = ''
      ..content = 'National Institutes of Health';

RPConsentSection whatToKnowSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'What are some things you should know?'
  ..summary = ''
  ..content =
      'We want you to be in a research study. We will ask you questions about your health. We will give you a count of everyone living in your ZIP code with similar health problems. We will ask you about the local air quality. We will also share information about local air pollution. \n\nBy signing up for this study, you will receive two daily alerts on your mobile phone. One is a reminder is to share how you are feeling that day. The second reminder is a reminder to report if you have noticed any pollution problems that day.';

RPConsentSection whyStudySection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'Why are we doing this study?'
  ..summary = ''
  ..content =
      'The study is to learn about human exposure to air pollutants in Colfax/Louisiana and health problems for residents. We want to share local air pollution data with you. We also want to learn if residents’ health problems are related to air pollution. \n\nLearning about your health issues and environmental observations will help us to understand if air pollution sources near you are causing health effects. \n\nWe also want to give Colfax/Louisiana residents a way to learn about air pollution. This app will provide information to you. It will also give you an easy way to report problems.';

RPConsentSection whatWillHappenSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'What will happen if you are in the study?'
  ..summary = ''
  ..content =
      'If you say yes, you will fill out a one-time survey about your health and some personal characteristics (e.g., date of birth, race, income, education, exercise, smoking). Every day, you will get a pop-up on your phone asking you to fill out a short survey about the health symptoms you feel that day. \n\nYou will get a second pop-up on your phone asking you about air pollution for the day. You will also be asked if would like to report an air pollution problem to the Louisiana Department of Environmental Quality (LDEQ). If you say yes, you will be asked some questions. That information will be automatically submitted to LDEQ. \n\nYou can open the app at any time to see how your health symptoms compare to your neighbors (people living in the same ZIP code). You will also be able to see air quality information for your area, report a problem, and see reports that your neighbors have made.';

RPConsentSection canIBeStudySection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'Can I be in the study?'
  ..summary = ''
  ..content =
      'If you are 18 years old or older and live in Louisiana, you can be in this study.';

RPConsentSection risksBenefitsSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'Risks and benefits'
  ..summary = ''
  ..content =
      'Use of a mobile phone app creates special risks, including privacy risks and risks of device integrity. Risks to your private information are greater with any mobile app. It is possible that your information could be hacked, especially if you use your phone on an unsecured Wi-Fi network, and being able to view the app on a personal device. Unintentional viewing can occur if a device changes hands. This could happen is you chose to let someone else handle your phone. It could also happen if you lose your phone, if it is stolen, or if police take it as part of a search warrant or subpoena. We attempt to address privacy risks by removing names and encrypting your data. \n\nThe benefit of being part of this study is that you can learn about how your health symptoms compare with those of your neighbors, you can learn about local air quality, and you can have a quick way to report problems to the Louisiana Department of Environmental Quality.';

RPConsentSection rightToStopSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'Right to stop'
  ..summary = ''
  ..content =
      'You can stop being in the study if you don’t want to do it anymore. You don’t need a reason. If you want to stop participating, you can turn off the notifications and only use the app to learn about your local air quality. Or, you can simply delete the app. No additional pop-ups will appear if you do. \n\nPlease call Dr. Jennifer Bryant, NC State University Department of Forestry and Environmental Resources, 2800 Faucette Drive, Raleigh, NC 27695-8008, (919-360-1466) if you no longer want your data to be part of the study. If that is the case, we will destroy the record of your data.';

RPConsentSection privacySection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'Privacy'
  ..summary = ''
  ..content =
      'It is important for you to know that you can trust us. Data will be de-identified by assigning each participant a code number. One-time health survey data, daily health symptom data, and daily environmental observation data will be stored in a database with a code number. That number will be kept in a second database with personal information, including name, address, phone number, email address. Both databases will be encrypted.';

RPConsentSection rewardSection =
    RPConsentSection.withParams(RPConsentSectionType.Custom)
      ..title = 'Reward'
      ..summary = ''
      ..content =
          'You will not receive a reward for being part of this study. ';

RPConsentSection fundingSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'Funding'
  ..summary = ''
  ..content =
      'This research is paid for in part by the National Institutes for Health Superfund Research Program. The money is being given to the Louisiana State University Superfund Research Center (LSU SRC) (2 P42 ES013648-08A1) and in part by the Louisiana Department of Health (VCAF-19-128-004). \n\nThis means that the sponsor is paying LSU to do the research. The researchers do not get extra money for running the study. If you want more information, please ask Dr. Bryant. Her contact information is (919-360-1466) and jrbryan3@ncsu.edu.';

RPConsentSection haveQuestionsSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = 'What if you have questions about this study?'
  ..summary = ''
  ..content =
      'If you have any questions, please call Dr. Jennifer Bryant (919-360-1466). Dr. Bryant is in charge of the study. \n\nIf you have questions about your rights during the interview, call North Carolina State University (919-515-8754) or email irb-director@ncsu.edu.';

RPConsentSignature signature =
    RPConsentSignature.withIdentifier('consentSignatureID');

RPConsentDocument consentDocument =
    RPConsentDocument.withParams('Demo Consent', [
  titleSection,
  piSection,
  fundingSrcSection,
  whatToKnowSection,
  whyStudySection,
  whatWillHappenSection,
  canIBeStudySection,
  risksBenefitsSection,
  rightToStopSection,
  privacySection,
  rewardSection,
  fundingSection,
  haveQuestionsSection,
]);
// ..addSignature(signature);

// RPVisualConsentStep consentVisualStep =
//     RPVisualConsentStep('visualStep', consentDocument);

RPConsentReviewStep consentReviewStep = RPConsentReviewStep(
    'consentreviewstepID', consentDocument)
  ..reasonForConsent =
      'By tapping AGREE I am saying I accept the risks of being in this study. I know that I can stop being in the study at any time.'
  ..text = 'Agreed?'
  ..title = 'Consent Review Step Title';

RPCompletionStep completionStep = RPCompletionStep('completionID')
  ..title = 'Thank You!'
  ..text = 'We saved your consent document.';

RPOrderedTask consentTask = RPOrderedTask(
  'consentTaskID',
  [consentReviewStep, completionStep],
  closeAfterFinished: false, navigationPageId: PaticipantInfoScreen2.id
);
//navigationPageId: PaticipantInfoScreen.id
