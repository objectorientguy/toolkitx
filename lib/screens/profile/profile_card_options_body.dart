import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/data_util.dart';
import '../onboarding/widgets/custom_card.dart';

class ProfileCardOptionsBody extends StatelessWidget {
  const ProfileCardOptionsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.03)),
        child: Padding(
            padding: EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.width * 0.05),
            child: Column(children: [
              Material(
                  elevation: kElevation,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.13),
                  child: CircleAvatar(
                      backgroundColor: AppColor.blueGrey,
                      radius: MediaQuery.of(context).size.width * 0.13,
                      child: Icon(Icons.person,
                          size: MediaQuery.of(context).size.width * 0.1))),
              const SizedBox(height: mediumSpacing),
              Text("Aditya Rana", style: Theme.of(context).textTheme.large),
              const SizedBox(height: tiniestSpacing),
              Text("System User", style: Theme.of(context).textTheme.xSmall),
              const SizedBox(height: mediumSpacing),
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.12,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: DataUtil.profileCardOptionsList().length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: [
                          Icon(DataUtil.profileCardOptionsList()
                              .elementAt(index)
                              .iconData),
                          const SizedBox(height: tiniestSpacing),
                          Text(
                              DataUtil.profileCardOptionsList()
                                  .elementAt(index)
                                  .title,
                              style: Theme.of(context).textTheme.xxSmall)
                        ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.165);
                      }))
            ])));
  }
}
