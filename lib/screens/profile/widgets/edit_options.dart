import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/circle_avatar.dart';
import '../../onboarding/widgets/custom_card.dart';
import 'edit_options_section.dart';

class EditOptions extends StatelessWidget {
  const EditOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        child: Padding(
            padding: const EdgeInsets.all(tinySpacing),
            child: Column(children: [
              const CircleAvatarWidget(imagePath: 'avatar-icon.png'),
              const SizedBox(height: mediumSpacing),
              Text("Aditya Rana", style: Theme.of(context).textTheme.large),
              const SizedBox(height: tiniestSpacing),
              Text("System User", style: Theme.of(context).textTheme.xSmall),
              const SizedBox(height: mediumSpacing),
              const EditOptionsSection()
            ])));
  }
}
