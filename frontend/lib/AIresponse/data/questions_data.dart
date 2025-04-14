import 'package:frontend/AIresponse/const/kenums.dart';
import 'package:frontend/AIresponse/const/kquestion_ids.dart';
import 'package:frontend/AIresponse/models/questions_data_model.dart';
import 'package:frontend/AIresponse/const/ktheme.dart';

List<QuestionsDataModel> questionsData = [
  QuestionsDataModel(
    questionId: 'countrySelection',
    question: "Choose your Country",
    bg: Ktheme.nyayapathMeshGrad,
    questionType: KEnumQuestionType.countryDropdown,
  ),
  QuestionsDataModel(
    questionId: KquestionIds.perkSelection,
    question: "What do you wants to know?",
    bg: Ktheme.nyayapathMeshGrad,
    questionType: KEnumQuestionType.multiSelectCheckBox,
    options: [
      'Punishments',
      'Laws, Act & Sections',
      'Resources',
    ],
  ),
  QuestionsDataModel(
    questionId: KquestionIds.defendantTypeSelection,
    question: "Are you a _",
    bg: Ktheme.nyayapathMeshGrad,
    questionType: KEnumQuestionType.singleSelectCheckBox,
    options: ['Company', 'Individual', 'Other'],
  ),
  QuestionsDataModel(
    questionId: KquestionIds.shortTextAns,
    question: "Tell me about the situation in max 250 chars.",
    bg: Ktheme.nyayapathMeshGrad,
    questionType: KEnumQuestionType.shortText,
  ),
];
