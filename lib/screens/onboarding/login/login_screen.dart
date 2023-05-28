import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/login/login_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/circle_avatar.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/primary_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/text_field.dart';
import 'password_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'LoginScreen';
  final Map emailMap = {};

  LoginScreen({Key? key}) : super(key: key);

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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatarWidget(imagePath: 'email.png'),
                      const SizedBox(height: largeSpacing),
                      CustomCard(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(kCardRadius)),
                          child: Padding(
                              padding: const EdgeInsets.all(cardPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(StringConstants.kEmailAddress,
                                        style:
                                            Theme.of(context).textTheme.medium),
                                    const SizedBox(height: tinySpacing),
                                    TextFieldWidget(
                                        textInputType:
                                            TextInputType.emailAddress,
                                        onTextFieldChanged: (String textField) {
                                          emailMap['email'] = textField;
                                        })
                                  ]))),
                      const SizedBox(height: mediumSpacing),
                      BlocListener<LoginBloc, LoginStates>(
                          listener: (context, state) {
                            if (state is ValidatingEmail) {
                              ProgressBar.show(context);
                            }
                            if (state is EmailValidated) {
                              ProgressBar.dismiss(context);
                              Navigator.pushNamed(
                                  context, PasswordScreen.routeName);
                            }
                            if (state is ValidateEmailError) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(
                                  context, state.message, StringConstants.kOk);
                            }
                          },
                          child: PrimaryButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                    ValidateEmail(email: emailMap['email']));
                              },
                              textValue: StringConstants.kNext))
                    ]))));
  }
}
