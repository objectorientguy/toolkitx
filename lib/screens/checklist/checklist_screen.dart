import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/screens/onboarding/widgets/onboarding_app_bar.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const OnBoardingAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomSpacing,
              bottom: topBottomSpacing),
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, index) {
                return CustomCard(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Tank Maintenance'),
                        Text('Testint-Dummy')
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: tinySpacing);
              }),
        ));
  }
}
