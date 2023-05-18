import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/modules_util.dart';

class OffLineModules extends StatelessWidget {
  const OffLineModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: extraLargeSpacing,
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
        const SizedBox(height: midTinySpacing),
        GridView.builder(
            primary: false,
            itemCount: 1,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: midTinySpacing,
                mainAxisSpacing: midTinySpacing),
            itemBuilder: (BuildContext context, int index) {
              return Card(
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
                    const SizedBox(height: tinySpacing),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: tiniestSpacing, right: tiniestSpacing),
                      child: Text(
                        ModulesUtil.listModulesMode[index].moduleName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
