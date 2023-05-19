import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/widgets/change_role_screen.dart';
import 'package:toolkit/screens/checklist/widgets/details_screen.dart';
import 'package:toolkit/screens/checklist/widgets/filters_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import 'widgets/details_label_section.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: Text(StringConstants.kChecklist,
                style: Theme.of(context).textTheme.medium)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin, right: leftRightMargin),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    constraints: const BoxConstraints(),
                    iconSize: kIconSize,
                    onPressed: () {
                      Navigator.pushNamed(context, FiltersScreen.routeName);
                    },
                    icon: const Icon(Icons.filter_alt_outlined)),
                IconButton(
                    constraints: const BoxConstraints(),
                    iconSize: kIconSize,
                    onPressed: () {
                      Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                    },
                    icon: const Icon(Icons.settings_outlined))
              ]),
              Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                contentPadding:
                                    const EdgeInsets.all(midTinySpacing),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: tiniestSpacing),
                                  child: Text('Tank Maintenance',
                                      style: Theme.of(context)
                                          .textTheme
                                          .small
                                          .copyWith(color: AppColor.black)),
                                ),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Testing-Dummy',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)),
                                      const SizedBox(height: tiniestSpacing),
                                      const DetailsLabelSection()
                                    ]),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailsScreen.routeName);
                                }));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: tinySpacing);
                      })),
              const SizedBox(height: tinySpacing)
            ])));
  }
}
