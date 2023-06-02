import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/profile/profile_bloc.dart';
import 'package:toolkit/blocs/profile/profile_events.dart';
import 'package:toolkit/blocs/profile/profile_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import '../../configs/app_dimensions.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/circle_avatar.dart';
import '../../widgets/error_section.dart';
import '../onboarding/widgets/custom_card.dart';
import 'widgets/edit_options_section.dart';
import 'widgets/profile_options.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(FetchUserProfile());
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomSpacing),
                child: BlocConsumer<ProfileBloc, ProfileStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is UserProfileFetching ||
                        currentState is UserProfileFetched,
                    listener: (context, state) {
                      if (state is LoggedOut) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, WelcomeScreen.routeName, (route) => true);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserProfileFetching) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserProfileFetched) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: mediumSpacing),
                              CustomCard(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(kCardRadius)),
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.all(tinySpacing),
                                      child: Column(children: [
                                        const CircleAvatarWidget(
                                            imagePath: 'mechanic_person.png'),
                                        const SizedBox(height: mediumSpacing),
                                        Text(state.userProfileModel.data!.fname,
                                            style: Theme.of(context)
                                                .textTheme
                                                .large),
                                        const SizedBox(height: tiniestSpacing),
                                        Text(state.userType,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall),
                                        const SizedBox(height: mediumSpacing),
                                        EditOptionsSection(
                                            userprofileDetails:
                                                state.userProfileModel.data!)
                                      ]))),
                              const SizedBox(height: tinySpacing),
                              const ProfileOptions()
                            ]);
                      }
                      if (state is UserProfileFetchError) {
                        return Center(
                            child: GenericReloadButton(
                                onPressed: () {
                                  context
                                      .read<ProfileBloc>()
                                      .add(FetchUserProfile());
                                },
                                textValue: StringConstants.kReload));
                      } else {
                        return const SizedBox();
                      }
                    }))));
  }
}
