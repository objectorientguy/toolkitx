import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../onboarding/widgets/text_field.dart';
import '../widgets/blood_group_expansion_tile.dart';

class EditScreen extends StatelessWidget {
  static const routeName = 'EditScreen';

  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.all(leftRightMargin),
            child: PrimaryButton(
                onPressed: () {}, textValue: StringConstants.kSave)),
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
                      const TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          hintText: StringConstants.kFirstName),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kLastName,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          hintText: StringConstants.kLastName),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kContact,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const TextFieldWidget(
                          textInputAction: TextInputAction.done,
                          hintText: StringConstants.kContact),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kBloodGroup,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const BloodGroupExpansionTile()
                    ]))));
  }
}
