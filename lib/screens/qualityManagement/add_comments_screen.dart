import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/qualityManagement/widgets/custom_outlined_button.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_spacing.dart';
import '../onboarding/widgets/text_field.dart';

class CommentsScreen extends StatelessWidget {
  static const routeName = 'CommentsScreen';

  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kAddComments),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin, right: leftRightMargin),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: mediumSpacing),
                      Text(StringConstants.kComments,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const TextFieldWidget(
                          textInputAction: TextInputAction.done,
                          hintText: StringConstants.kComments,
                          maxLength: 6),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kUploadPhotos,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      CustomOutlinedButton(
                          onPressed: () {}, label: StringConstants.kUpload),
                      const SizedBox(height: largeSpacing),
                      PrimaryButton(
                          onPressed: () {}, textValue: StringConstants.kSubmit)
                    ]))));
  }
}
