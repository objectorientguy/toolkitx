import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_app_bar.dart';
import 'widgets/injury_screen_body.dart';

class InjuriesScreen extends StatelessWidget {
  static const routeName = 'InjuriesScreen';

  const InjuriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenericAppBar(title: Text(StringConstants.kInjuries)),
      body: Padding(
          padding: EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomSpacing),
          child: InjuryScreenBody()),
    );
  }
}
