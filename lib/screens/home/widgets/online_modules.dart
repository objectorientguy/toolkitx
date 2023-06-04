import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/checklist_list_screen.dart';
import 'package:toolkit/screens/incident/incident_list_screen.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../permit/permit_list_screen.dart';

class OnLineModules extends StatelessWidget {
  final List availableModules;

  const OnLineModules({Key? key, required this.availableModules})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        primary: false,
        itemCount: availableModules.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: tinier,
            mainAxisSpacing: tinier),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () =>
                  navigateToModule(availableModules[index].keys, context),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kCardRadius)),
                  color: AppColor.lightestBlue,
                  shadowColor: AppColor.ghostWhite,
                  elevation: kCardElevation,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            child: Image.asset(
                                availableModules[index].moduleImage,
                                height: kModuleIconSize,
                                width: kModuleIconSize)),
                        const SizedBox(height: xxTinySpacing),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: xxTiniestSpacing,
                                right: xxTiniestSpacing),
                            child: Text(
                                DatabaseUtil
                                    .getText(availableModules[index].moduleName),
                                textAlign: TextAlign.center))
                      ])));
        });
  }

  navigateToModule(moduleKey, context) {
    switch (moduleKey) {
      case 'ptw':
        Navigator.pushNamed(context, PermitListScreen.routeName);
        break;
      case 'hse':
        Navigator.pushNamed(context, IncidentListScreen.routeName);
        break;
      case 'checklist':
        Navigator.pushNamed(context, ChecklistScreen.routeName);
        break;
    }
  }
}
