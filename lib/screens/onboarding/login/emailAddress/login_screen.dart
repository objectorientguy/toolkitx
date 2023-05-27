import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/login/password/password_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/circle_avatar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../../blocs/password/password_bloc.dart';
import '../../../../blocs/password/password_events.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

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
                            borderRadius: BorderRadius.circular(kCardRadius),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(cardPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(StringConstants.kEmailAddress,
                                        style:
                                            Theme.of(context).textTheme.medium),
                                    const SizedBox(height: tinySpacing),
                                    const TextFieldWidget(
                                        textInputType:
                                            TextInputType.emailAddress),
                                  ]))),
                      const SizedBox(height: mediumSpacing),
                      PrimaryButton(
                          onPressed: () {
                            context
                                .read<PasswordBloc>()
                                .add(UserTypeDropDown(typeValue: 'null'));
                            Navigator.pushNamed(
                                context, PasswordScreen.routeName);
                          },
                          textValue: StringConstants.kNext)
                    ]))));
  }
}
