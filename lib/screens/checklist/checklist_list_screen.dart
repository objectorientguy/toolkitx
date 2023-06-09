import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/change_role_screen.dart';
import 'package:toolkit/screens/checklist/details_screen.dart';
import 'package:toolkit/screens/checklist/filters_screen.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import 'widgets/details_label_section.dart';

class ChecklistScreen extends StatelessWidget {
  static const routeName = 'ChecklistScreen';

  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChecklist),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // The row will be changed with Custom widget.
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
              const SizedBox(height: tiniest),
              Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(tinier),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: xxTinierSpacing),
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
                                      const SizedBox(height: xxTinySpacing),
                                      const DetailsLabelSection()
                                    ]),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailsScreen.routeName);
                                }));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: xxTinySpacing);
                      })),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
