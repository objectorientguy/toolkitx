import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/system_user_checklist_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import 'package:toolkit/widgets/text_button.dart';

import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../onboarding/widgets/text_field.dart';
import '../systemUser/schedule_dates_screen.dart';

class ApprovePopUp extends StatelessWidget {
  final String textValue;
  final List responseIdList;
  final Map approveMap = {};

  ApprovePopUp(
      {Key? key, required this.textValue, required this.responseIdList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChecklistBloc, ChecklistStates>(
        listener: (BuildContext context, state) {
          if (state is ChecklistApprovingData) {
            ProgressBar.show(context);
          } else if (state is ChecklistDataApproved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(context,
                SystemUserScheduleDatesScreen.routeName, (route) => false);
          } else if (state is ChecklistApproveError) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.message, StringConstants.kOk);
          }
        },
        child: AlertDialog(
            titlePadding:
                const EdgeInsets.only(left: smallSpacing, top: smallSpacing),
            buttonPadding: const EdgeInsets.all(tiniestSpacing),
            contentPadding: const EdgeInsets.only(
                left: tinySpacing,
                right: tinySpacing,
                top: tinySpacing,
                bottom: 0),
            actionsPadding: const EdgeInsets.only(
                right: tinySpacing, bottom: tiniestSpacing),
            title: Text(StringConstants.kComments,
                style: Theme.of(context)
                    .textTheme
                    .small
                    .copyWith(color: AppColor.black)),
            content: TextFieldWidget(
                onTextFieldValueChanged: (String textValue) {
                  approveMap["comment"] = textValue;
                },
                maxLines: 7),
            titleTextStyle: Theme.of(context)
                .textTheme
                .large
                .copyWith(fontWeight: FontWeight.w500),
            actions: [
              CustomTextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textValue: StringConstants.kRemove),
              CustomTextButton(
                  onPressed: () {
                    context
                        .read<ChecklistBloc>()
                        .add(ChecklistApprove(approveMap: approveMap));
                  },
                  textValue: textValue)
            ]));
  }
}
