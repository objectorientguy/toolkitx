import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/profile_util.dart';
import 'logout.dart';

class EditOptionsSection extends StatelessWidget {
  const EditOptionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, EditScreen.routeName);
        },
        child: Column(children: [
          Image.asset(ProfileUtil.editOptionsList().elementAt(0).image,
              height: kProfileImageHeight, width: kProfileImageWidth),
          const SizedBox(height: tiniestSpacing),
          Text(ProfileUtil.editOptionsList().elementAt(0).title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.xxSmall)
        ]),
      ),
      Column(children: [
        Image.asset(ProfileUtil.editOptionsList().elementAt(1).image,
            height: kProfileImageHeight, width: kProfileImageWidth),
        const SizedBox(height: tiniestSpacing),
        Text(ProfileUtil.editOptionsList().elementAt(1).title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.xxSmall)
      ]),
      GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return const Logout();
              });
        },
        child: Column(children: [
          Image.asset(ProfileUtil.editOptionsList().elementAt(2).image,
              height: kProfileImageHeight, width: kProfileImageWidth),
          const SizedBox(height: tiniestSpacing),
          Text(ProfileUtil.editOptionsList().elementAt(2).title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.xxSmall)
        ]),
      )
    ]);
  }
}
