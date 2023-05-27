import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/onboarding/widgets/password_body.dart';
import 'package:toolkit/screens/root/root_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_app_bar.dart';

class PasswordScreen extends StatelessWidget {
  static const routeName = 'PasswordScreen';
  final Map loginMap = {};

  PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomSpacing,
                    bottom: topBottomSpacing),
                child: BlocListener<LoginBloc, LoginStates>(
                    listener: (BuildContext context, state) {
                      if (state is LoginLoading) {
                        ProgressBar.show(context);
                      }
                      if (state is LoginLoaded) {
                        ProgressBar.dismiss(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            RootScreen.routeName,
                            (Route<dynamic> route) => false);
                      }
                      if (state is LoginError) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(context, state.message, '');
                      }
                      if (state is GeneratingOtpLogin) {
                        ProgressBar.show(context);
                      }
                      if (state is LoginOtpGenerated) {
                        if (state.generateOtpLoginModel.message != '1') {
                          showCustomSnackBar(
                              context,
                              StringConstants.kTryAgainInSomeTime,
                              StringConstants.kOk);
                        }
                        ProgressBar.dismiss(context);
                      }
                      if (state is GenerateOtpLoginError) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context,
                            StringConstants.kOtpUnsuccessful,
                            StringConstants.kOk);
                      }
                    },
                    child: PasswordBody()))));
  }
}
