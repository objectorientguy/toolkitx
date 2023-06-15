import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/modules_util.dart';
import '../../permit/permit_list_screen.dart';

class OffLineModules extends StatelessWidget {
  const OffLineModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: xxLargerSpacing,
          color: AppColor.errorRed,
          child: Center(
            child: Text(
              StringConstants.kNoInternetMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(color: AppColor.white),
            ),
          ),
        ),
        const SizedBox(height: tinier),
        GridView.builder(
            primary: false,
            itemCount: 1,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: tinier,
                mainAxisSpacing: tinier),
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
                          DatabaseUtil.getText(
                              ModulesUtil.listModulesMode[index].moduleName),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

  navigateToModule(index, context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, PermitListScreen.routeName);
        break;
    }
  }
}
