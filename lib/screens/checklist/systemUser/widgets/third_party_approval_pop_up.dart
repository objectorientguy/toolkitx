import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_third_party_approve_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_third_party_approve_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_third_party_approve_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_bloc.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../../../widgets/progress_bar.dart';
import '../../../../widgets/text_button.dart';
import '../sys_user_schedule_dates_screen.dart';

class ThirdPartyApprovePopUp extends StatelessWidget {
  final String textValue;
  final List responseIdList;

  ThirdPartyApprovePopUp(
      {Key? key, required this.textValue, required this.responseIdList})
      : super(key: key);
  final Map thirdPartyApproveMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThirdPartyApproveBloc, ThirdPartyApproveStates>(
        listener: (BuildContext context, state) {
          if (state is ThirdPartyApproving) {
            ProgressBar.show(context);
          } else if (state is ThirdPartyApproved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, SystemUserScheduleDatesScreen.routeName,
                arguments: context.read<ScheduleDatesBloc>().checklistId);
          } else if (state is ThirdPartyNotApproved) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        },
        child: AlertDialog(
            titlePadding:
                const EdgeInsets.only(left: tiny, top: tiny, right: tiny),
            buttonPadding: const EdgeInsets.all(tiniest),
            contentPadding: const EdgeInsets.only(
                left: xxTinySpacing,
                right: xxTinySpacing,
                top: xxTinySpacing,
                bottom: 0),
            actionsPadding:
                const EdgeInsets.only(right: xxTinySpacing, bottom: tiniest),
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
              const SizedBox(height: xxTinierSpacing),
              TextFieldWidget(
                  textInputAction: TextInputAction.done,
                  maxLength: 250,
                  onTextFieldChanged: (String textValue) {
                    thirdPartyApproveMap["name"] = textValue;
                  }),
              const SizedBox(height: xxTinierSpacing),
              Text('Add Signature',
                  style: Theme.of(context)
                      .textTheme
                      .small
                      .copyWith(color: AppColor.black)),
            ]),
            content: TextFieldWidget(
                onTextFieldChanged: (String textValue) {
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
                    context.read<ThirdPartyApproveBloc>().add(
                        ThirdPartyApproveCheckList(
                            thirdPartyApproveMap: thirdPartyApproveMap,
                            responseIdList: responseIdList));
                  },
                  textValue: textValue)
            ]));
  }
}
