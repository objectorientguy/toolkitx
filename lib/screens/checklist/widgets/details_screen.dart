import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/widgets/details_status_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../configs/app_color.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'DetailsScreen';

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin, right: leftRightMargin),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: tinySpacing),
              Text('Tank Maintenance',
                  style: Theme.of(context).textTheme.medium),
              const SizedBox(height: tinySpacing),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return CustomCard(
                        child: ListTile(
                      title: Text('08.03.2023 - 11.03.2023',
                          style: Theme.of(context).textTheme.xSmall),
                      subtitle: Text('1 response out of 2',
                          style: Theme.of(context)
                              .textTheme
                              .xxSmall
                              .copyWith(color: AppColor.grey)),
                      onTap: () {
                        Navigator.pushNamed(
                            context, DetailsStatusScreen.routeName);
                      },
                    ));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: tinySpacing);
                  },
                ),
              ),
              const SizedBox(height: tinySpacing)
            ])));
  }
}
