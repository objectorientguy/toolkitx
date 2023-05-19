import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/qualityManagement/details_screen.dart';
import 'package:toolkit/screens/qualityManagement/new_qa_reporting_screen.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../checklist/change_role_screen.dart';
import '../checklist/filters_screen.dart';
import '../onboarding/widgets/custom_card.dart';

class QMListScreen extends StatelessWidget {
  const QMListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kQAReporting),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, NewQAReportingScreen.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: midTiniestSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    constraints: const BoxConstraints(),
                    iconSize: kIconSize,
                    color: AppColor.grey,
                    onPressed: () {
                      Navigator.pushNamed(context, FiltersScreen.routeName);
                    },
                    icon: const Icon(Icons.filter_alt_outlined)),
                IconButton(
                    constraints: const BoxConstraints(),
                    color: AppColor.grey,
                    iconSize: kIconSize,
                    onPressed: () {
                      Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                    },
                    icon: const Icon(Icons.settings_outlined))
              ]),
              const SizedBox(height: midTiniestSpacing),
              Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                          contentPadding:
                              const EdgeInsets.all(midTiniestSpacing),
                          title: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: midTiniestSpacing),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('#RI0148',
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w600)),
                                    Text('CREATED',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xxSmall
                                            .copyWith(color: AppColor.deepBlue))
                                  ])),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Test',
                                    style: Theme.of(context).textTheme.xSmall),
                                const SizedBox(height: midTiniestSpacing),
                                Text('11.05.2023 17.190',
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(color: AppColor.grey)),
                                const SizedBox(height: midTiniestSpacing),
                                Text('Berlin Office-Belgium - WTG2',
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(color: AppColor.grey))
                              ]),
                          onTap: () {
                            Navigator.pushNamed(
                                context, QMDetailsScreen.routeName);
                          },
                        ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinySpacing);
                      })),
              const SizedBox(height: tinySpacing)
            ])));
  }
}
