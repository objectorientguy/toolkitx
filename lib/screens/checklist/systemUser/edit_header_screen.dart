import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/system_user_checklist_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../widgets/generic_text_field.dart';
import '../widgets/checklist_app_bar.dart';

class EditHeaderScreen extends StatelessWidget {
  static const routeName = 'EditHeaderScreen';

  EditHeaderScreen({Key? key}) : super(key: key);

  final List editHeader = [];

  Widget fetchEditHeaderSwitchCaseWidget(index, editHeaderData) {
    editHeader.add({
      "id": editHeaderData.id,
      "value": editHeaderData.fieldvalue,
      "ismandatory": editHeaderData.ismandatory
    });
    switch (index) {
      case 0:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 1:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 2:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 3:
        return TextFieldWidget(
            value: editHeaderData.fieldvalue,
            onTextFieldChanged: (String textValue) {
              editHeader[index]["value"] = textValue;
            });
      case 4:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldChanged: (String textValue) {
            editHeader[index]["value"] = textValue;
          },
        );
      case 5:
        return TextFieldWidget(
          value: editHeaderData.fieldvalue,
          onTextFieldChanged: (String textValue) {
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
    context.read<ChecklistBloc>().add(FetchEditHeader(scheduleId: ''));
    return Scaffold(
        appBar: ChecklistAppBar(
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
                top: topBottomPadding),
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
                                    const SizedBox(height: xxTinierSpacing),
                                    fetchEditHeaderSwitchCaseWidget(
                                        index,
                                        state.getCheckListEditHeaderModel
                                            .data![index]),
                                    const SizedBox(height: xxTinierSpacing),
                                  ]);
                            }),
                        const SizedBox(height: xxTinySpacing),
                        PrimaryButton(
                            onPressed: () {
                              context.read<ChecklistBloc>().add(SubmitHeader(
                                  submitHeaderMap:
                                      state.allChecklistDataMap["scheduleId"],
                                  submitHeaderList: editHeader));
                            },
                            textValue: StringConstants.kSubmit)
                      ]),
                    );
                  } else if (state is EditHeaderError) {
                    return GenericReloadButton(
                        onPressed: () {}, textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
