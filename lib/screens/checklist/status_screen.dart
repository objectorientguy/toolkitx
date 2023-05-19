import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import 'widgets/pop_up_menu.dart';

class ChecklistStatusScreen extends StatelessWidget {
  static const routeName = 'ChecklistStatusScreen';

  const ChecklistStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: Text('Tank Maintenance',
                style: Theme.of(context).textTheme.medium),
            actions: const [
              PopUpMenu(),
            ]),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('08.03.2023 - 11.03.2023',
                  style: Theme.of(context).textTheme.xSmall),
              const SizedBox(height: tinySpacing),
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
                                    child: Text('Sumit Workforce',
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(color: AppColor.black))),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Dummy data inserted here.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)),
                                      const SizedBox(height: tiniestSpacing),
                                      Text('Response Date: 08.04.2023',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)),
                                      const SizedBox(height: tiniestSpacing),
                                      Text('Approved',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey))
                                    ]),
                                trailing: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    iconSize: kIconSize,
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.attach_file_outlined))));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinySpacing);
                      }))
            ])));
  }
}
