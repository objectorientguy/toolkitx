import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/system_user_checklist_events.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/text_button.dart';

class RejectPopUp extends StatelessWidget {
  final String textValue;
  final List scheduleIdList;
  final Map rejectMap = {};

  RejectPopUp({Key? key, required this.textValue, required this.scheduleIdList})
      : super(key: key);

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
            titlePadding: const EdgeInsets.only(left: tiny, top: tiny),
            buttonPadding: const EdgeInsets.all(tiniest),
            contentPadding: const EdgeInsets.only(
                left: xxTinierSpacing,
                right: xxTinierSpacing,
                top: xxTinierSpacing,
                bottom: 0),
            actionsPadding:
                const EdgeInsets.only(right: xxTinierSpacing, bottom: tiniest),
            title: Text(StringConstants.kComments,
                style: Theme.of(context)
                    .textTheme
                    .small
                    .copyWith(color: AppColor.black)),
            content: TextFieldWidget(
                onTextFieldChanged: (String textValue) {
                  rejectMap["comment"] = textValue;
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
                        .add(ChecklistReject(rejectMap: rejectMap));
                  },
                  textValue: textValue)
            ]));
  }
}
