import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/workforce/editAnswer/workforce_edit_answer_bloc.dart';
import '../blocs/workforce/editAnswer/workforce_edit_answer_states.dart';
import '../screens/checklist/workforce/widgets/drop_down_expansion_tile.dart';
import '../screens/checklist/workforce/widgets/multi_select_expansion_tile.dart';
import '../screens/checklist/workforce/widgets/radio_button_expansion_tile.dart';
import '../screens/incident/widgets/date_picker.dart';
import '../screens/incident/widgets/time_picker.dart';
import '../widgets/generic_text_field.dart';
import 'constants/string_constants.dart';

class EditAnswerUtil {
  Widget fetchSwitchCaseWidget(
      type, index, answerModelList, answerList, context) {
    switch (type) {
      case 1:
        return TextFieldWidget(
            maxLines: 1,
            value: answerList[index]["answer"],
            onTextFieldChanged: (String textValue) {
              answerList[index]["answer"] = textValue;
              log("text 1======>${answerList[index]["answer"]}");
            });
      case 2:
        return TextFieldWidget(
            maxLines: 4,
            value: answerList[index]["answer"],
            onTextFieldChanged: (String textValue) {
              answerList[index]["answer"] = textValue;
              log("text 2======>${answerList[index]["answer"]}");
            });
      case 3:
        return DropDownExpansionTile(
          onValueChanged: (String dropDownId, String dropDownString) {
            answerList[index]["answer"] = dropDownId;
            log("ans=======>${answerList[index]["answer"]}");
          },
          answerModelList: answerModelList,
          index: index,
          value: '',
        );
      case 4:
        return RadioButtonExpansionTile(
            answerModelList: answerModelList,
            index: index,
            onRadioButtonChecked: (String radioId, String radioValue) {
              answerList[index]["answer"] = radioId;
            });
      case 5:
        return BlocBuilder<EditAnswerBloc, EditAnswerStates>(
            buildWhen: (previousState, currentState) =>
                currentState is AnswersEdited,
            builder: (context, state) {
              if (state is AnswersEdited) {
                answerList[index]["answer"] = state.multiSelectId
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", "");
                log("select====>${answerList[index]["answer"]}");
                return MultiSelectExpansionTile(
                    answerModelList: answerModelList,
                    index: index,
                    selectedIdList: state.multiSelectId,
                    selectedNamesList: state.multiSelectNames);
              } else {
                return const SizedBox();
              }
            });
      // case 6:
      //   return SecondaryButton(
      //       onPressed: () {
      //         showDialog(
      //             context: context,
      //             builder: (context) {
      //               return UploadAlertDialog(onCamera: () {}, onDevice: () {});
      //             });
      //       },
      //       textValue: StringConstants.kUpload);
      case 7:
        return TextFieldWidget(
            textInputType: TextInputType.number,
            value: answerList[index]["answer"],
            onTextFieldChanged: (String textValue) {
              log("text 7======>${answerList[index]["answer"]}");
              answerList[index]["answer"] = textValue;
            });
      case 8:
        return createDataTable(answerModelList, index);
      case 10:
        return DatePickerTextField(
          hintText: StringConstants.kSelectDate,
          editDate: answerList[index]["answer"],
          // onDatePicked: (String pickDate) {
          //   answerList[index]["answer"] = pickDate;
          //   log("date picked======>${answerList[index]["answer"]}");
          // }
        );
      case 11:
        return TimePickerTextField(
          editTime: answerList[index]["answer"],
          hintText: StringConstants.kSelectTime,
          // onTimePicked: (String timePicked) {
          //   answerList[index]["answer"] = timePicked;
          //   log("time picked======>${answerList[index]["answer"]}");
          // },
        );
      default:
        return Container();
    }
  }
}

createDataTable(answerModelList, index) {
  final List<dynamic> columnList = answerModelList[index].matrixcols!;
  String val = '';
  for (int i = 0; i < columnList.length; i++) {
    val = i.toString();
    DataTable(
      columns: [DataColumn(label: Text(i.toString()))],
      rows: List<DataRow>.generate(answerModelList[index].matrixrowcount,
          (index) {
        if (index < columnList.length) {
          return DataRow(
            cells: columnList.map((value) {
              return DataCell(
                  TextFieldWidget(onTextFieldChanged: (String textField) {}));
            }).toList(),
          );
        } else {
          return DataRow(
            cells: columnList.map((value) {
              return DataCell(
                  TextFieldWidget(onTextFieldChanged: (String textField) {}));
            }).toList(),
          );
        }
      }),
    );
  }
  // return DataTable(
  //     columns: [DataColumn(label: Text(val))],
  //     rows: List<DataRow>.generate(answerModelList[index].matrixrowcount,
  //         (index) {
  //       if (index < columnList.length) {
  //         return DataRow(
  //           cells: columnList.map((value) {
  //             return DataCell(
  //                 TextFieldWidget(onTextFieldChanged: (String textField) {}));
  //           }).toList(),
  //         );
  //       } else {
  //         return DataRow(
  //           cells: columnList.map((value) {
  //             return DataCell(
  //                 TextFieldWidget(onTextFieldChanged: (String textField) {}));
  //           }).toList(),
  //         );
  //       }
  //     }));
}

List<DataColumn> _buildColumns(
    List<dynamic> columnList, answerModelList, index) {
  return columnList.map((value) {
    return DataColumn(label: Text(value));
  }).toList();
}

List<DataRow> _buildRows(List<dynamic> columnList, answerModelList, index) {
  return columnList.map((value) {
    return DataRow(
        cells: columnList.map((value) {
      return DataCell(
          TextFieldWidget(onTextFieldChanged: (String textField) {}));
    }).toList());
  }).toList();
}
