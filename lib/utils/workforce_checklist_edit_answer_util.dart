import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_bloc.dart';
import '../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_states.dart';
import '../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';
import '../screens/checklist/workforce/widgets/drop_down_expansion_tile.dart';
import '../screens/checklist/workforce/widgets/multi_select_expansion_tile.dart';
import '../screens/checklist/workforce/widgets/radio_button_expansion_tile.dart';
import '../screens/checklist/workforce/widgets/upload_picture_container.dart';
import '../screens/incident/widgets/date_picker.dart';
import '../screens/incident/widgets/time_picker.dart';
import '../widgets/generic_text_field.dart';
import '../widgets/secondary_button.dart';
import '../widgets/upload_alert_dialog.dart';
import 'constants/string_constants.dart';

class EditAnswerUtil {
  Map value = {};
  var valueOfA = 0.0;
  List uploadImageList = [];

  Widget fetchSwitchCaseWidget(
      type, index, answerModelList, answerList, context) {
    switch (type) {
      case 1:
        return TextFieldWidget(
            maxLines: 1,
            maxLength: 250,
            textInputAction: TextInputAction.done,
            value: (answerModelList[index].optioncomment.toString() == "null" ||
                    answerModelList[index].optioncomment.toString() == "")
                ? ''
                : answerModelList[index].optioncomment,
            onTextFieldChanged: (String textValue) {
              answerList[index]["answer"] = textValue;
            });
      case 2:
        return TextFieldWidget(
            maxLines: 4,
            maxLength: 250,
            textInputAction: TextInputAction.done,
            value: (answerModelList[index].optioncomment.toString() == "null" ||
                    answerModelList[index].optioncomment.toString() == "")
                ? ''
                : answerModelList[index].optioncomment,
            onTextFieldChanged: (String textValue) {
              answerList[index]["answer"] = textValue;
            });
      case 3:
        return DropDownExpansionTile(
          onValueChanged: (String dropDownId, String dropDownString) {
            answerList[index]["answer"] = dropDownId;
          },
          answerModelList: answerModelList,
          index: index,
          value: (answerModelList[index].optiontext.toString() == "null" ||
                  answerModelList[index].optiontext.toString() == "")
              ? ''
              : answerModelList[index].optiontext,
        );
      case 4:
        return RadioButtonExpansionTile(
            answerModelList: answerModelList,
            index: index,
            onRadioButtonChecked: (String radioId, String radioValue) {
              answerList[index]["answer"] = radioId;
            },
            editValue:
                (answerModelList[index].optiontext.toString() == "null" ||
                        answerModelList[index].optiontext.toString() == "")
                    ? ''
                    : answerModelList[index].optiontext);
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
                return MultiSelectExpansionTile(
                    answerModelList: answerModelList,
                    index: index,
                    selectedIdList: state.multiSelectId,
                    selectedNamesList: state.multiSelectNames,
                    editValue: (answerModelList[index].optiontext.toString() ==
                                "null" ||
                            answerModelList[index].optiontext.toString() == "")
                        ? ''
                        : answerModelList[index].optiontext);
              } else {
                return const SizedBox();
              }
            });
      case 6:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          BlocBuilder<PickAndUploadImageBloc, PickAndUploadImageStates>(
              builder: (context, state) {
            if (state is PickImageLoading) {
              return const Padding(
                padding: EdgeInsets.all(xxTinierSpacing),
                child: SizedBox(
                    width: kProgressIndicatorTogether,
                    height: kProgressIndicatorTogether,
                    child: CircularProgressIndicator()),
              );
            } else if (state is ImagePickerLoaded) {
              uploadImageList.add(state.uploadPictureModel.data);
              answerList[index]["answer"] = uploadImageList
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "");

              return (state.isImageAttached == true)
                  ? UploadPictureContainer(
                      imagePathsList: state.imagePathsList,
                      isImageAttached: state.isImageAttached)
                  : const SizedBox();
            } else if (state is RemovePickedImage) {
              return Visibility(
                  visible: state.isImageAttached == true,
                  child: UploadPictureContainer(
                      imagePathsList: state.imagePathsList,
                      isImageAttached: state.isImageAttached));
            } else if (state is ImagePickerError) {
              return Text(
                state.errorMessage,
                style: const TextStyle(color: AppColor.errorRed),
              );
            } else {
              return const SizedBox();
            }
          }),
          SecondaryButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return UploadAlertDialog(onCamera: () {
                        context
                            .read<PickAndUploadImageBloc>()
                            .add(RequestCameraPermission());
                        Navigator.pop(context);
                      }, onDevice: () {
                        context
                            .read<PickAndUploadImageBloc>()
                            .add(RequestGalleryPermission());
                        Navigator.pop(context);
                      });
                    });
              },
              textValue: StringConstants.kUpload)
        ]);
      case 7:
        return TextFieldWidget(
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            value: (answerModelList[index].optioncomment.toString() == "null" ||
                    answerModelList[index].optioncomment.toString() == "")
                ? ''
                : answerModelList[index].optioncomment,
            onTextFieldChanged: (String textValue) {
              answerList[index]["answer"] = textValue;
            });
      case 8:
        return tableControl(index, answerModelList, answerList, context);
      case 9:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(StringConstants.kValueA,
                    style: Theme.of(context).textTheme.xSmall),
                const SizedBox(width: tiniest),
                SizedBox(
                    width: kTimeSpanFieldWidth,
                    height: xxSmallSpacing,
                    child: TextFieldWidget(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        maxLength: 8,
                        onTextFieldChanged: (String textField) {
                          valueOfA = double.parse(textField).toDouble();
                        }))
              ]),
          const SizedBox(height: tiny),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(StringConstants.kValueB,
                    style: Theme.of(context).textTheme.xSmall),
                const SizedBox(width: tiniest),
                SizedBox(
                    width: kTimeSpanFieldWidth,
                    height: xxSmallSpacing,
                    child: TextFieldWidget(
                        textInputType: TextInputType.number,
                        maxLength: 8,
                        onTextFieldChanged: (String textField) {
                          value = {
                            "valueA": valueOfA,
                            "valueB": double.parse(textField).toDouble(),
                          };
                          answerList[index]["answer"] = jsonEncode(value);
                        }))
              ])
        ]);
      case 10:
        return DatePickerTextField(
          hintText: StringConstants.kSelectDate,
          editDate:
              (answerModelList[index].optioncomment.toString() == "null" ||
                      answerModelList[index].optioncomment.toString() == "")
                  ? ''
                  : answerModelList[index].optioncomment,
          onDateChanged: (String date) {
            answerList[index]["answer"] = date;
          },
        );
      case 11:
        return TimePickerTextField(
            editTime:
                (answerModelList[index].optioncomment.toString() == "null" ||
                        answerModelList[index].optioncomment.toString() == "")
                    ? ''
                    : answerModelList[index].optioncomment,
            hintText: StringConstants.kSelectTime,
            onTimeChanged: (String time) {
              answerList[index]["answer"] = time;
            });
      default:
        return Container();
    }
  }
}

Widget tableControl(index, answerModelList, answerList, context) {
  Map tableData = jsonDecode(answerList[index]["answer"]);
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            decoration: BoxDecoration(border: Border.all()),
            child: DataTable(
                border: TableBorder.all(),
                columnSpacing: xxxSmallestSpacing,
                columns: [
                  for (int i = 0;
                      i < answerModelList[index].matrixcols.length;
                      i++)
                    DataColumn(
                        label: Text(answerModelList[index].matrixcols[i]))
                ],
                rows: [
                  for (int j = 0;
                      j < answerModelList[index].matrixrowcount;
                      j++)
                    DataRow(cells: [
                      for (int k = 0;
                          k < answerModelList[index].matrixcols.length;
                          k++)
                        DataCell(SizedBox(
                            height: xMediumSpacing,
                            width: kDataCellWidth,
                            child: TextFieldWidget(
                                value: (tableData.toString() == "{}" &&
                                        answerModelList[index].type == 8)
                                    ? ""
                                    : tableData["data"][j][k],
                                onTextFieldChanged: (String textField) {
                                  tableData["data"][j][k] = textField;
                                  answerList[index]["answer"] =
                                      jsonEncode(tableData);
                                })))
                    ])
                ]))
      ]));
}
