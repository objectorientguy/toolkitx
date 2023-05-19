import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/qualityManagement/widgets/site_expansion_tile.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'widgets/impact_expansion_tile.dart';
import 'widgets/location_expansion_tile.dart';
import 'widgets/severity_expansion_tile.dart';

class ReportingScreen extends StatelessWidget {
  static const routeName = 'ReportingScreen';

  const ReportingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kNewQAReporting),
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
                      const SizedBox(height: mediumSpacing),
                      Text(StringConstants.kSite,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const SiteExpansionTile(),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kLocation,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const LocationExpansionTile(),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kSeverity,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const SeverityExpansionTile(),
                      const SizedBox(height: midTinySpacing),
                      Text(StringConstants.kImpact,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: midTinySpacing),
                      const ImpactExpansionTile()
                    ]))));
  }
}
