import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workforce/comments/workforce_comments_bloc.dart';
import 'package:toolkit/blocs/workforce/comments/workforce_comments_events.dart';
import 'package:toolkit/blocs/workforce/comments/workforce_comments_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_questions_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../blocs/workforce/getQuestionsList/get_questions_list_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class AddImageAndCommentScreen extends StatelessWidget {
  static const routeName = 'AddImageAndCommentScreen';
  final String questionResponseId;

  AddImageAndCommentScreen({Key? key, required this.questionResponseId})
      : super(key: key);
  final Map saveQuestionCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    context
        .read<CommentBloc>()
        .add(FetchComment(questionResponseId: questionResponseId));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kAddCommentImage),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<CommentBloc, CommentStates>(
                listener: (context, state) {
              if (state is SavingComment) {
                ProgressBar.show(context);
              } else if (state is CommentSaved) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, WorkForceQuestionsScreen.routeName,
                    arguments: context
                        .read<WorkForceQuestionsListBloc>()
                        .allDataForChecklistMap);
              } else if (state is CommentNotSaved) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, StringConstants.kOk);
              }
            }, builder: (context, state) {
              if (state is FetchingComment) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CommentFetched) {
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.getQuestionCommentsModel.data!.title,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: xxTinierSpacing),
                          Text(StringConstants.kComments,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: xxTinierSpacing),
                          TextFieldWidget(
                              textInputAction: TextInputAction.done,
                              value: state.getQuestionCommentsModel.data!
                                  .additionalcomment
                                  .toString(),
                              maxLines: 6,
                              maxLength: 250,
                              onTextFieldChanged: (String textValue) {
                                saveQuestionCommentsMap["comments"] = textValue;
                              }),
                          const SizedBox(height: xxTinierSpacing),
                          Text(StringConstants.kUploadPhoto,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondaryButton(
                                    onPressed: () {},
                                    textValue: StringConstants.kUpload)
                              ]),
                          const SizedBox(height: xxTinySpacing),
                          PrimaryButton(
                              onPressed: () {
                                context.read<CommentBloc>().add(SaveComment(
                                    saveQuestionCommentMap:
                                        saveQuestionCommentsMap));
                              },
                              textValue: StringConstants.kSave),
                        ]));
              } else if (state is CommentNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context.read<CommentBloc>().add(FetchComment(
                          questionResponseId: state.quesResponseId));
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox();
              }
            })));
  }
}