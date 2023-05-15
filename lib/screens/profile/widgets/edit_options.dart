import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/profile_util.dart';
import '../../../widgets/circle_avatar.dart';
import '../../onboarding/widgets/custom_card.dart';

class EditOptions extends StatelessWidget {
  const EditOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        child: Padding(
            padding: const EdgeInsets.all(midTinySpacing),
            child: Column(children: [
              CircleAvatarWidget(
                  radius: MediaQuery.of(context).size.width * 0.13,
                  borderRadius: kCircleAvatarRadius,
                  child: Icon(Icons.person,
                      size: MediaQuery.of(context).size.width * 0.1)),
              const SizedBox(height: mediumSpacing),
              Text("Aditya Rana", style: Theme.of(context).textTheme.large),
              const SizedBox(height: tiniestSpacing),
              Text("System User", style: Theme.of(context).textTheme.xSmall),
              const SizedBox(height: mediumSpacing),
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: ProfileUtil.editOptionsList().length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: ProfileUtil.editOptionsList()
                                    .elementAt(index)
                                    .image,
                                subtitle: Text(
                                    ProfileUtil.editOptionsList()
                                        .elementAt(index)
                                        .title,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.xxSmall)));
                      }))
            ])));
  }
}
