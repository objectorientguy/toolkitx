import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_states.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/questions_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../blocs/pickImage/pick_image_bloc.dart';
import '../../../blocs/pickImage/pick_image_events.dart';
import '../../../blocs/pickImage/pick_image_states.dart';
import '../../../blocs/uploadImage/upload_image_events.dart';
import '../../../configs/app_color.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/upload_alert_dialog.dart';
import 'widgets/upload_picture_container.dart';

class AddImageAndCommentScreen extends StatelessWidget {
  static const routeName = 'AddImageAndCommentScreen';

  AddImageAndCommentScreen({Key? key}) : super(key: key);
  final Map saveQuestionCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    String uploadImageFile = '';
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kAddCommentImages),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
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
                              value: state.getQuestionCommentsModel.data!
                                  .additionalcomment
                                  .toString(),
                              maxLines: 6,
                              onTextFieldChanged: (String textValue) {
                                saveQuestionCommentsMap["comments"] = textValue;
                              }),
                          const SizedBox(height: xxTinierSpacing),
                          Text(StringConstants.kUploadPhotos,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500)),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<PickImageBloc, PickImageStates>(
                                    builder: (context, state) {
                                  log("state====>$state");
                                  if (state is PickImageLoading) {
                                    return const SizedBox();
                                  } else if (state is ImagePickerLoaded) {
                                    uploadImageFile = state.imagePathsList
                                        .toString()
                                        .replaceAll("[", "")
                                        .replaceAll("]", "");
                                    log("listtttt state====>${state.imagePathsList}");
                                    log("image attached state====>${state.isImageAttached}");
                                    return Visibility(
                                        visible: state.isImageAttached == true,
                                        child: UploadPictureContainer(
                                            imagePathsList:
                                                state.imagePathsList,
                                            isImageAttached:
                                                state.isImageAttached));
                                  } else if (state is ImagePickerError) {
                                    return Text(
                                      state.errorMessage,
                                      style: const TextStyle(
                                          color: AppColor.errorRed),
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
                                            return UploadAlertDialog(
                                                onCamera: () {
                                              context.read<PickImageBloc>().add(
                                                  RequestCameraPermission());
                                              Navigator.pop(context);
                                            }, onDevice: () {
                                              context.read<PickImageBloc>().add(
                                                  RequestGalleryPermission());
                                              Navigator.pop(context);
                                            });
                                          });
                                    },
                                    textValue: StringConstants.kUpload)
                              ]),
                          const SizedBox(height: xxTinySpacing),
                          BlocListener<UploadImageBloc, UploadImageStates>(
                            listener: (context, state) {
                              if (state is UploadingImage) {
                                ProgressBar.show(context);
                              } else if (state is ImageUploaded) {
                                ProgressBar.dismiss(context);
                              } else if (state is ImageNotUploaded) {
                                showCustomSnackBar(
                                    context,
                                    state.imageNotUploaded,
                                    StringConstants.kOk);
                              }
                            },
                            child: PrimaryButton(
                                onPressed: () {
                                  context.read<UploadImageBloc>().add(
                                      UploadImageEvent(
                                          imageFile: uploadImageFile));
                                  context.read<WorkforceChecklistBloc>().add(
                                      SaveQuestionComment(
                                          saveQuestionCommentMap:
                                              saveQuestionCommentsMap));
                                },
                                textValue: StringConstants.kSave),
                          )
                        ]));
              } else if (state is QuestionCommentsError) {
                return GenericReloadButton(
                    onPressed: () {
                      context.read<WorkforceChecklistBloc>().add(
                          FetchQuestionComment(
                              questionResponseId: state.quesResponseId));
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
