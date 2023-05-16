import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../blocs/editProfile/edit_profile_bloc.dart';
import '../../../blocs/editProfile/edit_profile_events.dart';
import '../../../blocs/editProfile/edit_profile_states.dart';
import '../../../configs/app_color.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../onboarding/widgets/text_field.dart';
import '../widgets/blood_group_expansion_tile.dart';

class EditScreen extends StatelessWidget {
  static const routeName = 'EditScreen';
  final Map editProfileDetails = {};

  EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        bottomNavigationBar: BottomAppBar(
            color: AppColor.white,
            elevation: 0,
            padding: const EdgeInsets.all(leftRightMargin),
            child: BlocListener<EditProfileBloc, EditProfileStates>(
              listener: (context, state) {
                if (state is EditProfileLoading) {
                  const CircularProgressIndicator();
                } else if (state is EditProfileLoaded) {
                  Navigator.pop(context);
                } else if (state is EditProfileValidation) {
                  showCustomSnackBar(
                      context, state.message, StringConstants.kOk);
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    context.read<EditProfileBloc>().add(
                        EditProfile(editProfileDetails: editProfileDetails));
                  },
                  textValue: StringConstants.kSave),
            )),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin, right: leftRightMargin),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: mediumSpacing),
                      Text(StringConstants.kFirstName,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          onTextFieldValueChanged: (String textFieldValue) {
                            editProfileDetails['firstName'] = textFieldValue;
                          },
                          hintText: StringConstants.kFirstName),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kLastName,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          onTextFieldValueChanged: (String textFieldValue) {
                            editProfileDetails['lastName'] = textFieldValue;
                          },
                          hintText: StringConstants.kLastName),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kContact,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      TextFieldWidget(
                          textInputAction: TextInputAction.done,
                          onTextFieldValueChanged: (String textFieldValue) {
                            editProfileDetails['contact'] = textFieldValue;
                          },
                          hintText: StringConstants.kContact),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kBloodGroup,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const BloodGroupExpansionTile()
                    ]))));
  }
}
