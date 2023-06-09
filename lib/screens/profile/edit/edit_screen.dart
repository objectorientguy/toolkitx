import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/generic_text_field.dart';

class EditScreen extends StatelessWidget {
  static const routeName = 'EditScreen';

  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        bottomNavigationBar: BottomAppBar(
            color: AppColor.white,
            elevation: kZeroElevation,
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
                      const SizedBox(height: xxxSmallerSpacing),
                      Text(StringConstants.kFirstName,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinier),
                      TextFieldWidget(
                        textInputAction: TextInputAction.next,
                        hintText: StringConstants.kFirstName,
                        onTextFieldChanged: (String textField) {},
                      ),
                      const SizedBox(height: tinier),
                      Text(StringConstants.kLastName,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinier),
                      TextFieldWidget(
                        textInputAction: TextInputAction.next,
                        hintText: StringConstants.kLastName,
                        onTextFieldChanged: (String textField) {},
                      ),
                      const SizedBox(height: tinier),
                      Text(StringConstants.kContact,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinier),
                      TextFieldWidget(
                        textInputAction: TextInputAction.done,
                        hintText: StringConstants.kContact,
                        onTextFieldChanged: (String textField) {},
                      ),
                      const SizedBox(height: tinier),
                      Text(StringConstants.kBloodGroup,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinier),
                      // const BloodGroupExpansionTile()
                    ]))));
  }
}
