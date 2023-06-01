import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/checklist_list_screen.dart';
import 'package:toolkit/screens/incident/incident_list_screen.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/modules_util.dart';

class OnLineModules extends StatelessWidget {
  const OnLineModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        primary: false,
        itemCount: ModulesUtil.listModulesMode.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: tinierSpacing,
            mainAxisSpacing: tinierSpacing),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => navigateToModule(index, context),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardRadius),
              ),
              color: AppColor.lightestBlue,
              shadowColor: AppColor.ghostWhite,
              elevation: kCardElevation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                        ModulesUtil.listModulesMode[index].moduleImage,
                        height: kModuleIconSize,
                        width: kModuleIconSize),
                  ),
                  const SizedBox(height: xxTinySpacing),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: xxTiniestSpacing, right: xxTiniestSpacing),
                    child: Text(
                      ModulesUtil.listModulesMode[index].moduleName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  navigateToModule(index, context) {
    switch (index) {
      case 4:
        Navigator.pushNamed(context, PermitListScreen.routeName);
        break;
      case 6:
        Navigator.pushNamed(context, IncidentListScreen.routeName);
        break;
      case 13:
        Navigator.pushNamed(context, ChecklistScreen.routeName);
        break;
    }
  }
}
