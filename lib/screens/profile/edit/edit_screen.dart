import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/profile/profile_bloc.dart';
import 'package:toolkit/blocs/profile/profile_events.dart';
import 'package:toolkit/blocs/profile/profile_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/root/root_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/generic_text_field.dart';
import '../widgets/blood_group_expansion_tile.dart';

class EditScreen extends StatelessWidget {
  static const routeName = 'EditScreen';

  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin, right: leftRightMargin),
                child: BlocConsumer<ProfileBloc, ProfileStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is EditProfileInitialized,
                    listener: (BuildContext context, state) {
                      if (state is UserProfileUpdating) {
                        ProgressBar.show(context);
                      }
                      if (state is UserProfileUpdated) {
                        ProgressBar.dismiss(context);
                        Navigator.pushNamed(context, RootScreen.routeName);
                      }
                      if (state is UserProfileUpdateError) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context, state.message, StringConstants.kOk);
                      }
                    },
                    builder: (context, state) {
                      if (state is EditProfileInitialized) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: xxxSmallerSpacing),
                              Text(StringConstants.kFirstName,
                                  style: Theme.of(context).textTheme.medium),
                              const SizedBox(height: tinier),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['fname'],
                                  textInputAction: TextInputAction.next,
                                  hintText: StringConstants.kFirstName,
                                  onTextFieldChanged: (String textField) {
                                    state.profileDetailsMap['fname'] =
                                        textField;
                                  }),
                              const SizedBox(height: tinier),
                              Text(StringConstants.kLastName,
                                  style: Theme.of(context).textTheme.medium),
                              const SizedBox(height: tinier),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['lname'],
                                  textInputAction: TextInputAction.next,
                                  hintText: StringConstants.kLastName,
                                  onTextFieldChanged: (String textField) {
                                    state.profileDetailsMap['lname'] =
                                        textField;
                                  }),
                              const SizedBox(height: tinier),
                              Text(StringConstants.kContact,
                                  style: Theme.of(context).textTheme.medium),
                              const SizedBox(height: tinier),
                              TextFieldWidget(
                                  value: state.profileDetailsMap['contact'],
                                  textInputAction: TextInputAction.done,
                                  hintText: StringConstants.kContact,
                                  onTextFieldChanged: (String textField) {
                                    state.profileDetailsMap['contact'] =
                                        textField;
                                  }),
                              const SizedBox(height: tinier),
                              Text(StringConstants.kBloodGroup,
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
                                  textValue: StringConstants.kSave)
                            ]);
                      } else {
                        return const SizedBox();
                      }
                    }))));
  }
}
