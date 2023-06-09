import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import '../../../blocs/profile/profile_bloc.dart';
import '../../../blocs/profile/profile_events.dart';
import '../../../blocs/profile/profile_states.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../../root/root_screen.dart';
import '../widgets/blood_group_expansion_tile.dart';

class ProfileEditScreen extends StatelessWidget {
  static const routeName = 'ProfileEditScreen';

  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(DecryptUserProfileData());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('MyProfile')),
        body: BlocConsumer<ProfileBloc, ProfileStates>(
            buildWhen: (previousState, currentState) =>
                currentState is EditProfileInitialized ||
                currentState is EditProfileInitializing,
            listener: (BuildContext context, state) {
              if (state is UserProfileUpdating) {
                ProgressBar.show(context);
              }
              if (state is UserProfileUpdated) {
                ProgressBar.dismiss(context);
                Navigator.pushNamed(context, RootScreen.routeName,
                    arguments: false);
              }
              if (state is UserProfileUpdateError) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, '');
              }
              if (state is UserProfileUpdateCancel) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is EditProfileInitializing) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EditProfileInitialized) {
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: leftRightMargin, right: leftRightMargin),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: xxxSmallerSpacing),
                              Text(DatabaseUtil.getText('FirstName'),
                                  style: Theme.of(context).textTheme.medium),
                              const SizedBox(height: tinier),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['fname'],
                                  textInputAction: TextInputAction.next,
                                  hintText: DatabaseUtil.getText('FirstName'),
                                  onTextFieldChanged: (String textField) {
                                    state.profileDetailsMap['fname'] =
                                        textField;
                                  }),
                              const SizedBox(height: tinier),
                              Text(DatabaseUtil.getText('LastName'),
                                  style: Theme.of(context).textTheme.medium),
                              const SizedBox(height: tinier),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['lname'],
                                  textInputAction: TextInputAction.next,
                                  hintText: DatabaseUtil.getText('LastName'),
                                  onTextFieldChanged: (String textField) {
                                    state.profileDetailsMap['lname'] =
                                        textField;
                                  }),
                              const SizedBox(height: tinier),
                              Text(DatabaseUtil.getText('Contact'),
                                  style: Theme.of(context).textTheme.medium),
                              const SizedBox(height: tinier),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['contact'],
                                  textInputAction: TextInputAction.done,
                                  hintText: DatabaseUtil.getText('Contact'),
                                  onTextFieldChanged: (String textField) {
                                    state.profileDetailsMap['contact'] =
                                        textField;
                                  }),
                              const SizedBox(height: tinier),
                              Text(DatabaseUtil.getText('BloodGroup'),
                                  style: Theme.of(context).textTheme.medium),
                              const SizedBox(height: tinier),
                              BloodGroupExpansionTile(
                                  profileDetailsMap: state.profileDetailsMap),
                              const SizedBox(height: xxxSmallerSpacing),
                              PrimaryButton(
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(
                                        UpdateProfile(
                                            updateProfileMap:
                                                state.profileDetailsMap));
                                  },
                                  textValue: DatabaseUtil.getText('buttonSave'))
                            ])));
              } else if (state is EditProfileError) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(DecryptUserProfileData());
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            }));
  }
}
