import 'package:flutter/material.dart';
import 'package:toolkit/screens/incident/widgets/injury_screen_body.dart';

import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';

class IncidentInjuriesScreen extends StatelessWidget {
  static const routeName = 'IncidentInjuriesScreen';

  const IncidentInjuriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenericAppBar(title: 'Injuries'),
      body: Padding(
          padding: EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxxTinierSpacing),
          child: InjuryScreenBody(
            injuryNatureList: [],
            injuredPersonDetails: {},
          )),
    );
  }
}
