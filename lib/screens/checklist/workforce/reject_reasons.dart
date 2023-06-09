import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_events.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_states.dart';
import 'package:toolkit/screens/checklist/workforce/questions_list_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_text_field.dart';

class RejectReasonsScreen extends StatelessWidget {
  static const routeName = 'RejectReasonsScreen';

  const RejectReasonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String reasonValue = '';
    context.read<WorkforceChecklistBloc>().add(FetchRejectReasons());
    return Scaffold(
        appBar: const GenericAppBar(title: 'Checklist Reject'),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<WorkforceChecklistBloc,
                    WorkforceChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is RejectReasonsFetched ||
                    currentState is FetchingRejectReasons ||
                    currentState is RejectReasonsError,
                listener: (context, state) {
                  if (state is SavingRejectReasons) {
                    ProgressBar.show(context);
                  } else if (state is RejectReasonsSaved) {
                    ProgressBar.dismiss(context);
                    Navigator.pushReplacementNamed(
                        context, WorkForceQuestionsList.routeName);
                  } else if (state is RejectReasonsNotSaved) {
                    showCustomSnackBar(
                        context, state.message, StringConstants.kOk);
                  }
                },
                builder: (context, state) {
                  if (state is FetchingRejectReasons) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RejectReasonsFetched) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCard(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state
                                      .getCheckListRejectReasonsModel
                                      .data!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                        dense: true,
                                        activeColor: AppColor.deepBlue,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(state
                                            .getCheckListRejectReasonsModel
                                            .data![index]
                                            .reasontext),
                                        value: state
                                            .getCheckListRejectReasonsModel
                                            .data![index]
                                            .reasontext,
                                        groupValue: state.reason,
                                        onChanged: (value) {
                                          value = state
                                              .getCheckListRejectReasonsModel
                                              .data![index]
                                              .reasontext;
                                          context
                                              .read<WorkforceChecklistBloc>()
                                              .add(SelectRejectReasons(
                                                  getCheckListRejectReasonsModel:
                                                      state
                                                          .getCheckListRejectReasonsModel,
                                                  reason: value));
                                        });
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                        thickness: kDividerThickness,
                                        height: kDividerHeight);
                                  })),
                          const SizedBox(height: xxTinySpacing),
                          TextFieldWidget(
                            maxLines: 6,
                            hintText: StringConstants.kEnterReason,
                            onTextFieldChanged: (String textValue) {
                              reasonValue = textValue;
                            },
                          ),
                          const SizedBox(height: xxTinySpacing),
                          PrimaryButton(
                              onPressed: () {
                                context.read<WorkforceChecklistBloc>().add(
                                    SaveRejectReasons(
                                        reason: (state.reason == "null")
                                            ? reasonValue
                                            : state.reason));
                              },
                              textValue: StringConstants.kSave)
                        ]);
                  } else if (state is RejectReasonsError) {
                    return GenericReloadButton(
                        onPressed: () {}, textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
