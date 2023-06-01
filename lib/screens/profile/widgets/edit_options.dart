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
            padding: const EdgeInsets.all(xxTinySpacing),
            child: Column(children: [
              const CircleAvatarWidget(imagePath: 'mechanic_person.png'),
              const SizedBox(height: xxxSmallerSpacing),
              Text("Aditya Rana", style: Theme.of(context).textTheme.large),
              const SizedBox(height: xxTiniestSpacing),
              Text("System User", style: Theme.of(context).textTheme.xSmall),
              const SizedBox(height: xxxSmallerSpacing),
              const EditOptionsSection()
            ])));
  }
}
