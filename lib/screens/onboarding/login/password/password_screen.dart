import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/password/password_bloc.dart';
import 'package:toolkit/blocs/password/password_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/root/root_screen.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/text_button.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';
import '../../../../widgets/circle_avatar.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../widgets/type_expansion_tile.dart';

class PasswordScreen extends StatelessWidget {
  static const routeName = 'PasswordScreen';

  const PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        body:
            BlocBuilder<PasswordBloc, PasswordSates>(builder: (context, state) {
          if (state is UserTypeDropDownLoaded) {
            return SingleChildScrollView(
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
                          const CircleAvatarWidget(
                              imagePath: 'reset-password.png'),
                          const SizedBox(height: largeSpacing),
                          Text(StringConstants.kWelcome,
                              style: Theme.of(context).textTheme.xLarge),
                          const SizedBox(height: smallSpacing),
                          CustomCard(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kCardRadius),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(cardPadding),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(StringConstants.kPassword,
                                            style: Theme.of(context)
                                                .textTheme
                                                .medium),
                                        const SizedBox(height: smallSpacing),
                                        const TextFieldWidget(),
                                        const SizedBox(height: smallSpacing),
                                        Text(StringConstants.kType,
                                            style: Theme.of(context)
                                                .textTheme
                                                .medium),
                                        const SizedBox(height: smallSpacing),
                                        UserTypeExpansionTile(
                                            typeValue: state.typeValue)
                                      ]))),
                          CustomTextButton(
                              onPressed: () {},
                              textValue: StringConstants.kGenerateOtp),
                          PrimaryButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RootScreen.routeName);
                              },
                              textValue: StringConstants.kLogin)
                        ])));
          } else {
            return const SizedBox();
          }
        }));
  }
}
