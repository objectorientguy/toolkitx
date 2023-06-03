import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checklist_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/checklist/systemUser/checklist_events.dart';

class EditHeaderScreen extends StatelessWidget {
  static const routeName = 'EditHeaderScreen';
  final String scheduleId;

  EditHeaderScreen({Key? key, required this.scheduleId}) : super(key: key);
  final Map editHeaderMap = {};
  final List editHeader = [];

  Widget fetchEditHeaderSwitchCaseWidget(index, editHeaderData) {
    editHeaderMap["scheduleId"] = scheduleId;
    editHeader.add({
      "id": editHeaderData.id,
      "value": editHeaderData.fieldvalue,
      "ismandatory": editHeaderData.ismandatory
    });
    switch (index) {
      case 0:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldValueChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 1:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldValueChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 2:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldValueChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 3:
        return TextFieldWidget(
            value: editHeaderData.fieldvalue,
            onTextFieldValueChanged: (String textValue) {
              editHeader[index]["value"] = textValue;
            });
      case 4:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldValueChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 5:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldValueChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      default:
        return Container(
          color: AppColor.deepBlue,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChecklistBloc>().add(FetchEditHeader(scheduleId: scheduleId));
    return Scaffold(
        appBar: GenericAppBar(
            title: BlocBuilder<ChecklistBloc, ChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is EditHeaderFetched,
                builder: (context, state) {
                  if (state is EditHeaderFetched) {
                    return Text(state
                        .getCheckListEditHeaderModel.data![0].checklistname);
                  } else {
                    return const SizedBox();
                  }
                })),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: BlocConsumer<ChecklistBloc, ChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is EditHeaderFetched,
                listener: (context, state) {
                  if (state is SubmittingHeader) {
                    ProgressBar.show(context);
                  } else if (state is HeaderSubmitted) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, StringConstants.kDataSaved,
                        StringConstants.kOk);
                  } else if (state is SubmitHeaderError) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, state.message, StringConstants.kOk);
                  }
                },
                builder: (context, state) {
                  if (state is EditHeaderFetched) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                state.getCheckListEditHeaderModel.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        state.getCheckListEditHeaderModel
                                            .data![index].title,
                                        style:
                                            Theme.of(context).textTheme.medium),
                                    const SizedBox(height: midTiniestSpacing),
                                    fetchEditHeaderSwitchCaseWidget(
                                        index,
                                        state.getCheckListEditHeaderModel
                                            .data![index]),
                                    const SizedBox(height: midTiniestSpacing),
                                  ]);
                            }),
                        const SizedBox(height: tinySpacing),
                        PrimaryButton(
                            onPressed: () {
                              context.read<ChecklistBloc>().add(SubmitHeader(
                                  submitHeaderMap: editHeaderMap,
                                  submitHeaderList: editHeader));
                            },
                            textValue: StringConstants.kSubmit)
                      ]),
                    );
                  } else if (state is EditHeaderError) {
                    return ShowError(onPressed: () {});
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
