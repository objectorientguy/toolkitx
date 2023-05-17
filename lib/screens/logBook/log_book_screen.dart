import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/screens/onboarding/widgets/onboarding_app_bar.dart';

class LogBookScreen extends StatelessWidget {
  static const routeName = 'LogBookScreen';

  const LogBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const OnBoardingAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin, right: leftRightMargin),
            child: Column(children: [
              const SizedBox(height: mediumSpacing),
              const Placeholder(
                  fallbackHeight: 100, fallbackWidth: 100, strokeWidth: 1.0),
              const SizedBox(height: mediumSpacing),
              Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                dense: true,
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: tiniestSpacing),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('Daily Log'),
                                      SizedBox(height: tiniestSpacing),
                                      Text('Daily Progress Sheet'),
                                    ],
                                  ),
                                ),
                                subtitle: const Text('20.04.2023 08:42'),
                                trailing: const Text('Open')));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: tinySpacing);
                      }))
            ])));
  }
}
