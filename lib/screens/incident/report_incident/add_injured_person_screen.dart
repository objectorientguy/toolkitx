import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/primary_button.dart';
import 'injuries_screen.dart';

class AddInjuredPersonScreen extends StatelessWidget {
  static const routeName = 'AddInjuredPersonScreen';

  const AddInjuredPersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const GenericAppBar(title: Text(StringConstants.kAddInjuredPerson)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin, top: tinySpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, InjuriesScreen.routeName);
                },
                icon: const Icon(Icons.add, color: AppColor.mediumBlack),
                label: Text(
                  StringConstants.kAddInjuredPersonDetails,
                  style: Theme.of(context).textTheme.xSmall,
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: AppColor.blueGrey,
                    minimumSize: Size(MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.width * 0.11))),
            const SizedBox(height: mediumSpacing),
            PrimaryButton(onPressed: () {}, textValue: StringConstants.kDone)
          ],
        ),
      ),
    );
  }
}
