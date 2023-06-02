import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';

import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_events.dart';
import '../../../blocs/login/login_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/circle_avatar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/text_button.dart';
import 'custom_card.dart';
import 'type_expansion_tile.dart';

class PasswordBody extends StatelessWidget {
  final Map loginMap = {};

  PasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const CircleAvatarWidget(imagePath: 'reset-password.png'),
      const SizedBox(height: largeSpacing),
      Text(StringConstants.kWelcome, style: Theme.of(context).textTheme.xLarge),
      const SizedBox(height: smallSpacing),
      CustomCard(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kCardRadius)),
          child: Padding(
              padding: const EdgeInsets.all(cardPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringConstants.kPassword,
                        style: Theme.of(context).textTheme.medium),
                    const SizedBox(height: smallSpacing),
                    TextFieldWidget(onTextFieldChanged: (String textField) {
                      loginMap['password'] = textField;
                    }),
                    BlocBuilder<LoginBloc, LoginStates>(
                        buildWhen: (previousState, currentState) =>
                            currentState is UserTypeChanged,
                        builder: (context, state) {
                          if (state is UserTypeChanged) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: smallSpacing),
                                  Text(StringConstants.kType,
                                      style:
                                          Theme.of(context).textTheme.medium),
                                  const SizedBox(height: smallSpacing),
                                  UserTypeExpansionTile(
                                      typeValue: state.typeValue,
                                      usertype: state.userType)
                                ]);
                          } else {
                            return const SizedBox();
                          }
                        })
                  ]))),
      CustomTextButton(
          onPressed: () {
            context.read<LoginBloc>().add(GenerateLoginOtp());
          },
          textValue: StringConstants.kGenerateOtp),
      PrimaryButton(
          onPressed: () {
            context.read<LoginBloc>().add(LoginEvent(loginMap: loginMap));
          },
          textValue: StringConstants.kLogin),
    ]);
  }
}
