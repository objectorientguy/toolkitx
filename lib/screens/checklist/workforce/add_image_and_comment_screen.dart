import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/questions_list_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/upload_alert_dialog.dart';

class AddImageAndCommentScreen extends StatelessWidget {
  static const routeName = 'AddImageAndCommentScreen';

  AddImageAndCommentScreen({Key? key}) : super(key: key);
  final Map saveQuestionCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const GenericAppBar(title: Text(StringConstants.kAddCommentImages)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: BlocConsumer<WorkforceChecklistBloc, WorkforceChecklistStates>(
            buildWhen: (previousState, currentState) =>
                currentState is QuestionCommentsFetched,
            listener: (context, state) {
              if (state is SavingQuestionComments) {
                ProgressBar.show(context);
              } else if (state is QuestionCommentsSaved) {
                ProgressBar.dismiss(context);
                Navigator.pushReplacementNamed(
                    context, WorkForceQuestionsList.routeName);
              } else if (state is QuestionCommentsNotSaved) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, StringConstants.kOk);
              }
            },
            builder: (context, state) {
              if (state is QuestionCommentsFetched) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.getQuestionCommentsModel.data!.title,
                        style: Theme.of(context).textTheme.small.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: midTiniestSpacing),
                    Text(StringConstants.kComments,
                        style: Theme.of(context).textTheme.small.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: midTiniestSpacing),
                    TextFieldWidget(
                        value: state
                            .getQuestionCommentsModel.data!.additionalcomment
                            .toString(),
                        maxLines: 6,
                        onTextFieldValueChanged: (String textValue) {
                          saveQuestionCommentsMap["comments"] = textValue;
                        }),
                    const SizedBox(height: midTiniestSpacing),
                    Text(StringConstants.kUploadPhotos,
                        style: Theme.of(context).textTheme.small.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: midTiniestSpacing),
                    SecondaryButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return UploadAlertDialog(
                                    onCamera: () {}, onDevice: () {});
                              });
                        },
                        textValue: StringConstants.kUpload),
                    const SizedBox(height: tinySpacing),
                    PrimaryButton(
                        onPressed: () {
                          context.read<WorkforceChecklistBloc>().add(
                              SaveQuestionComment(
                                  saveQuestionCommentMap:
                                      saveQuestionCommentsMap));
                        },
                        textValue: StringConstants.kSave)
                  ],
                );
              } else if (state is QuestionCommentsError) {
                return ShowError(onPressed: () {
                  context.read<WorkforceChecklistBloc>().add(
                      FetchQuestionComment(
                          questionResponseId: state.quesResponseId));
                });
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
