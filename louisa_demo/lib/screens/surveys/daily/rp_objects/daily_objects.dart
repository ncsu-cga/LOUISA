import 'package:louisa_demo/screens/home/paticipant_nav_bottom.dart';
import 'package:research_package/research_package.dart';

import 'package:louisa_demo/models/dialog_step.dart';
import 'package:louisa_demo/demo.dart';

//----- Yes & No answers
List<RPChoice> yesNo = [
  RPChoice.withParams('Yes', 0),
  RPChoice.withParams('No', 1),
];

RPChoiceAnswerFormat yesNoChoiceAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, yesNo);
RPBooleanAnswerFormat yesNoAnswerFormat =
    RPBooleanAnswerFormat.withParams('Yes', 'No');

//----- Every Day Survey -----
RPInstructionStep dailyHealthQuestionInstruction = RPInstructionStep(
  identifier: 'dailyHealthQuestionInstructionId',
  title: 'Daily Health Questions',
)..text = 'We would like to ask about how you are feeling today.';

RPQuestionStep symptomsTodayQuestionStep = RPQuestionStep.withAnswerFormat(
    'symptomsTodayQuestionId',
    'Do you feel any health symptoms today?',
    yesNoChoiceAnswerFormat);
RPStepJumpRule symptomsTodayBranchRule =
    RPStepJumpRule(symptomsTodayQuestionStep.identifier, {
  0: symptomsQuestionStep.identifier,
  1: completionStep.identifier,
});
List<RPChoice> symptoms = [
  RPChoice.withParams('Body aches', 1),
  RPChoice.withParams('Burning eyes, nose, or throat', 2),
  RPChoice.withParams('Chest pain/heart palpitations', 3),
  RPChoice.withParams('Cough/sneezing', 4),
  RPChoice.withParams('Diarrhea/nausea/vomiting', 5),
  RPChoice.withParams('Dizziness', 6),
  RPChoice.withParams('Tiredness', 7),
  RPChoice.withParams('Fever', 8),
  RPChoice.withParams('Headache', 9),
  RPChoice.withParams('Itchy skin', 10),
  RPChoice.withParams('Loss of smell', 11),
  RPChoice.withParams('Difficulty breathing', 12),
  RPChoice.withParams('Swelling', 13),
  RPChoice.withParams('Other', 14, true),
];

RPChoiceAnswerFormat symptomsAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, symptoms);

RPQuestionStep symptomsQuestionStep = RPQuestionStep.withAnswerFormat(
  'symptomsQuestionStepID',
  '(if they feel symptoms today) Which symptoms do you feel today?',
  symptomsAnswerFormat,
);

DialogStep dialog911Step = DialogStep('call911ID')..dialog = 'CALL_EMERGENCY';
DialogStep dialogDoctorStep = DialogStep('callDoctorID')
  ..dialog = 'CALL_DOCTOR';

RPResultPredicate choice911Predicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('symptomsQuestionStepID'),
        expectedValue: [3, 12],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);

RPResultPredicate choiceCallDoctorPredicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('symptomsQuestionStepID'),
        expectedValue: [14],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);

RPPredicateStepNavigationRule dialogNavigationRule =
    RPPredicateStepNavigationRule(
  {
    choice911Predicate: dialog911Step.identifier,
    choiceCallDoctorPredicate: dialogDoctorStep.identifier,
  },
);

Map<String, List<DialogStep>> dialogPredicateSteps = {
  'symptomsQuestionStepID': [dialog911Step, dialogDoctorStep]
};

RPCompletionStep completionStep = RPCompletionStep('completionID')
  ..title = 'End of Daily Health Questions'
  ..text =
      'You have completed Daily Health Survey.\n Thank you for filling out the survey!';

RPNavigableOrderedTask navigableDailyHealthSurveyTask = RPNavigableOrderedTask(
  'dailyHealthSurveyTaskID',
  [
    dailyHealthQuestionInstruction,
    symptomsTodayQuestionStep,
    symptomsQuestionStep,
    dialog911Step,
    dialogDoctorStep,
    completionStep,
  ],
  predicateSteps: dialogPredicateSteps,
  closeAfterFinished: false,
  navigationPageId: DemoHome.id,
)
  ..setNavigationRuleForTriggerStepIdentifier(
      symptomsTodayBranchRule, symptomsTodayQuestionStep.identifier)
  ..setNavigationRuleForTriggerStepIdentifier(
      dialogNavigationRule, symptomsQuestionStep.identifier);
