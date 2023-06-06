import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/system_user_checklist_events.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/text_button.dart';
import '../../onboarding/widgets/text_field.dart';

class ThirdPartyApprovePopUp extends StatelessWidget {
  final String textValue;

  ThirdPartyApprovePopUp({Key? key, required this.textValue}) : super(key: key);
  final Map thirdPartyApproveMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChecklistBloc, ChecklistStates>(
        listener: (BuildContext context, state) {
          if (state is ApprovingThirdParty) {
            ProgressBar.show(context);
          } else if (state is ThirdPartyApproved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
          } else if (state is ThirdPartyDisapprove) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.message, StringConstants.kOk);
          }
        },
        child: AlertDialog(
            titlePadding: const EdgeInsets.only(
                left: smallSpacing, top: smallSpacing, right: smallSpacing),
            buttonPadding: const EdgeInsets.all(tiniestSpacing),
            contentPadding: const EdgeInsets.only(
                left: tinySpacing,
                right: tinySpacing,
                top: tinySpacing,
                bottom: 0),
            actionsPadding: const EdgeInsets.only(
                right: tinySpacing, bottom: tiniestSpacing),
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter your name',
                      style: Theme.of(context)
                          .textTheme
                          .small
                          .copyWith(color: AppColor.black)),
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_outlined, size: kIconSize))
                ],
              ),
              const SizedBox(height: midTiniestSpacing),
              TextFieldWidget(onTextFieldValueChanged: (String textValue) {
                thirdPartyApproveMap["name"] = textValue;
              }),
              const SizedBox(height: midTiniestSpacing),
              Text('Add Signature',
                  style: Theme.of(context)
                      .textTheme
                      .small
                      .copyWith(color: AppColor.black)),
            ]),
            content: TextFieldWidget(
                onTextFieldValueChanged: (String textValue) {
                  thirdPartyApproveMap["sign_text"] = textValue;
                },
                maxLines: 7),
            actions: [
              CustomTextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textValue: StringConstants.kRemove),
              CustomTextButton(
                  onPressed: () {
                    context.read<ChecklistBloc>().add(ThirdPartyApprove(
                        thirdPartyApprove: thirdPartyApproveMap));
                  },
                  textValue: textValue)
            ]));
  }
}
