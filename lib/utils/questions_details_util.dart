// import '../data/models/checklist/workforce/questions_list_model.dart';
//
// abstract class QuestionDetailsUtil {
//   static const String answer = '';
//
//   static questionsDetailsSwitchCase() {
//     final GetQuestionListModel getQuestionListModel = GetQuestionListModel();
//     switch (getQuestionListModel.data!.questionlist![index].type) {
//       case 1:
//         answer = answerList[index]["answer"].toString().trim();
//         break;
//       case 2:
//         answer = answerList[index]["answer"].toString().trim();
//         break;
//       case 3:
//         answer = (answerList[index]["answer"].toString() == 'null')
//             ? ''
//             : (getQuestionListModel.data!.questionlist![index].queoptions!
//                         .indexWhere((item) =>
//                             item["queoptionid"].toString() ==
//                             answerList[index]["answer"]) !=
//                     -1)
//                 ? getQuestionListModel.data!.questionlist![index]
//                     .queoptions![index]["queoptiontext"]
//                 : 'Nothing';
//         break;
//       case 4:
//         answer = (answerList[index].toString() == 'null')
//             ? ''
//             : (getQuestionListModel.data!.questionlist![index].queoptions!
//                         .indexWhere((item) =>
//                             item["queoptionid"].toString() ==
//                             answerList[index]["answer"]) !=
//                     -1)
//                 ? getQuestionListModel.data!.questionlist![index].queoptions![0]
//                     ["queoptiontext"]
//                 : 'Nothing';
//         break;
//       case 5:
//         answer = (getQuestionListModel.data!.questionlist![index].queoptions!
//                     .indexWhere((item) =>
//                         item["queoptionid"].toString() ==
//                         answerList[index]["answer"]) !=
//                 -1)
//             ? getQuestionListModel.data!.questionlist![index].queoptions![0]
//                 ["queoptiontext"]
//             : 'Nothing';
//         break;
//       case 6:
//         answer = answerList[index]["answer"].toString();
//         break;
//       case 7:
//         answer = answerList[index]["answer"].toString();
//         break;
//       case 8:
//         answer = answerList[index]["answer"].toString().trim();
//         break;
//       case 10:
//         answer = answerList[index]["answer"].toString();
//         break;
//       case 11:
//         answer = answerList[index]["answer"].toString();
//     }
//   }
// }
