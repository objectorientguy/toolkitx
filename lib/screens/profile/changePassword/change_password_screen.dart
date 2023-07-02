import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/profile/profile_bloc.dart';
import '../../../blocs/profile/profile_events.dart';
import '../../../blocs/profile/profile_states.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/text_button.dart';
import '../../root/root_screen.dart';

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
              top: topBottomPadding),
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
                          context, RootScreen.routeName,
                          arguments: false);
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
                      if (state.generateChangePasswordOtpModel.message == '1') {
                        showCustomSnackBar(context,
                            DatabaseUtil.getText('OTPSentMessage'), '');
                      } else {
                        showCustomSnackBar(
                            context, StringConstants.kTryAgainInSomeTime, '');
                      }
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
                                const SizedBox(height: tinierSpacing),
                                TextFieldWidget(
                                    obscureText: true,
                                    maxLength: 30,
                                    textInputAction: TextInputAction.next,
                                    hintText: StringConstants.kOldPassword,
                                    onTextFieldChanged: (String textField) {
                                      changePasswordMap['oldPass_opt'] =
                                          textField;
                                    }),
                                const SizedBox(height: tinierSpacing),
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
                                          textValue: DatabaseUtil.getText(
                                              'generateotp'))
                                    ]),
                                TextFieldWidget(
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    hintText: StringConstants.kEnterOtp,
                                    maxLength: 6,
                                    onTextFieldChanged: (String textField) {
                                      changePasswordMap['oldPass_opt'] =
                                          textField;
                                    }),
                                const SizedBox(height: tinierSpacing)
                              ]));
                    } else {
                      return const SizedBox();
                    }
                  }),
              Text(StringConstants.kEnterNewPassword,
                  style: Theme.of(context).textTheme.medium),
              const SizedBox(height: tinierSpacing),
              TextFieldWidget(
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  hintText: StringConstants.kEnterNewPassword,
                  maxLength: 30,
                  onTextFieldChanged: (String textField) {
                    changePasswordMap['newPassword'] = textField;
                  }),
              const SizedBox(height: tinierSpacing),
              Text(StringConstants.kConfirmPassword,
                  style: Theme.of(context).textTheme.medium),
              const SizedBox(height: tinierSpacing),
              TextFieldWidget(
                  obscureText: true,
                  maxLength: 30,
                  textInputAction: TextInputAction.next,
                  hintText: StringConstants.kConfirmPassword,
                  onTextFieldChanged: (String textField) {
                    changePasswordMap['confirmPassword'] = textField;
                  }),
              const SizedBox(height: xxxSmallerSpacing),
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
