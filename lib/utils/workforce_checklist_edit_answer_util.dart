import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_bloc.dart';
import '../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_states.dart';
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
          value: answerModelList[index].queoptions![index]["queoptiontext"],
        );
      case 4:
        return RadioButtonExpansionTile(
            answerModelList: answerModelList,
            index: index,
            onRadioButtonChecked: (String radioId, String radioValue) {
              answerList[index]["answer"] = radioId;
            },
            editValue: answerModelList[index].queoptions![0]["queoptiontext"]);
      case 5:
        return BlocBuilder<WorkForceCheckListEditAnswerBloc,
                WorkForceCheckListEditAnswerStates>(
            buildWhen: (previousState, currentState) =>
                currentState is CheckListAnswersEdited,
            builder: (context, state) {
              if (state is CheckListAnswersEdited) {
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
        return tableControl(index, answerModelList, answerList, context);
      case 10:
        return DatePickerTextField(
          hintText: StringConstants.kSelectDate,
          // editDate: answerList[index]["answer"],
          onDateChanged: (String date) {
            answerList[index]["answer"] = date;
            log("date picked======>${answerList[index]["answer"]}");
          },
        );
      case 11:
        return TimePickerTextField(
          // editTime: answerList[index]["answer"],
          hintText: StringConstants.kSelectTime,
          onTimeChanged: (String time) {
            answerList[index]["answer"] = time;
            log("time picked======>${answerList[index]["answer"]}");
          },
        );
      default:
        return Container();
    }
  }
}

Widget tableControl(index, answerModelList, answerList, context) {
  // List items = [];
  // List rowsItems = [];
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child:
              DataTable(border: TableBorder.all(), columnSpacing: 20, columns: [
            const DataColumn(label: Text('')),
            for (int i = 0; i < answerModelList[index].matrixcols.length; i++)
              DataColumn(label: Text(answerModelList[index].matrixcols[i]))
          ], rows: [
            for (int j = 0; j < answerModelList[index].matrixrowcount; j++)
              DataRow(cells: [
                DataCell(SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child:
                      TextFieldWidget(onTextFieldChanged: (String textField) {
                    answerList[index]["answer"] = textField;
                  }),
                )),
                for (int k = 0;
                    k < answerModelList[index].matrixcols.length;
                    k++)
                  DataCell(SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child:
                        TextFieldWidget(onTextFieldChanged: (String textField) {
                      answerList[index]["answer"] = textField;
                      log("row items value======>${answerList[index]["answer"]}");
                    }),
                  ))
              ])
          ])));
}
