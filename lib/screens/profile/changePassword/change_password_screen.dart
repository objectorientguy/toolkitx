import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/profile/profile_bloc.dart';
import 'package:toolkit/blocs/profile/profile_events.dart';
import 'package:toolkit/blocs/profile/profile_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/root/root_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import 'package:toolkit/widgets/text_button.dart';

import '../../../configs/app_spacing.dart';
import '../../onboarding/widgets/text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = 'ChangePasswordScreen';
  final Map changePasswordMap = {};

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChangePassword),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<ProfileBloc, ProfileStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is ChangePasswordTypeChecked,
                  listener: (context, state) {
                    if (state is PasswordChanging) {
                      ProgressBar.show(context);
                    }
                    if (state is PasswordChanged) {
                      ProgressBar.dismiss(context);
                      Navigator.pushReplacementNamed(
                          context, RootScreen.routeName);
                    }
                    if (state is ChangePasswordError) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(
                          context, state.message, StringConstants.kOk);
                    }
                    if (state is GeneratingChangePasswordOtp) {
                      ProgressBar.show(context);
                    }
                    if (state is ChangePasswordOtpGenerated) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, StringConstants.kOtpGenerated,
                          StringConstants.kOk);
                    }
                    if (state is ChangePasswordOtpError) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(
                          context, state.message, StringConstants.kOk);
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangePasswordTypeChecked) {
                      return Visibility(
                          visible: state.changePasswordOtp,
                          replacement: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(StringConstants.kOldPassword,
                                    style: Theme.of(context).textTheme.medium),
                                const SizedBox(height: midTinySpacing),
                                TextFieldWidget(
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    hintText: StringConstants.kOldPassword,
                                    onTextFieldChanged: (String textField) {
                                      changePasswordMap['oldPass_opt'] =
                                          textField;
                                    }),
                                const SizedBox(height: midTinySpacing),
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(StringConstants.kEnterOtp,
                                          style: Theme.of(context)
                                              .textTheme
                                              .medium),
                                      CustomTextButton(
                                          onPressed: () {
                                            context.read<ProfileBloc>().add(
                                                GenerateChangePasswordOtp());
                                          },
                                          textValue:
                                              StringConstants.kGenerateOtp)
                                    ]),
                                TextFieldWidget(
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    hintText: StringConstants.kEnterOtp,
                                    onTextFieldChanged: (String textField) {
                                      changePasswordMap['oldPass_opt'] =
                                          textField;
                                    }),
                                const SizedBox(height: midTinySpacing)
                              ]));
                    } else {
                      return const SizedBox();
                    }
                  }),
              Text(StringConstants.kEnterNewPassword,
                  style: Theme.of(context).textTheme.medium),
              const SizedBox(height: midTinySpacing),
              TextFieldWidget(
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  hintText: StringConstants.kEnterNewPassword,
                  onTextFieldChanged: (String textField) {
                    changePasswordMap['newPassword'] = textField;
                  }),
              const SizedBox(height: midTinySpacing),
              Text(StringConstants.kConfirmPassword,
                  style: Theme.of(context).textTheme.medium),
              const SizedBox(height: midTinySpacing),
              TextFieldWidget(
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  hintText: StringConstants.kConfirmPassword,
                  onTextFieldChanged: (String textField) {
                    changePasswordMap['confirmPassword'] = textField;
                  }),
              const SizedBox(height: mediumSpacing),
              PrimaryButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(
                        ChangePassword(changePasswordMap: changePasswordMap));
                  },
                  textValue: 'CHANGE PASSWORD')
            ],
          ),
        ));
  }
}
