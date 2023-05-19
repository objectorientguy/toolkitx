import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/qualityManagement/reporting_screen.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../onboarding/widgets/text_field.dart';
import 'widgets/contractor_expansion_tile.dart';
import 'widgets/report_anonymously_expansion_tile.dart';

class NewQAReportingScreen extends StatelessWidget {
  static const routeName = 'NewQAReportingScreen';

  const NewQAReportingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kNewQAReporting),
        bottomNavigationBar: BottomAppBar(
            color: AppColor.white,
            elevation: kZeroElevation,
            padding: const EdgeInsets.all(leftRightMargin),
            child: PrimaryButton(
                onPressed: () {
                  Navigator.pushNamed(context, ReportingScreen.routeName);
                },
                textValue: StringConstants.kNext)),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin, right: leftRightMargin),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: mediumSpacing),
                      Text(StringConstants.kReportAnonymously,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const ReportAnonymouslyExpansionTile(),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kContractor,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const ContractorExpansionTile(),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kDate,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const TextFieldWidget(
                          textInputAction: TextInputAction.done,
                          hintText: StringConstants.kDate),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kTime,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const TextFieldWidget(
                          textInputAction: TextInputAction.done,
                          hintText: StringConstants.kTime),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kDetailedDescription,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const TextFieldWidget(
                          textInputAction: TextInputAction.done,
                          hintText: StringConstants.kDescription,
                          maxLength: 6),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kUploadPhotos,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                    ]))));
  }
}
