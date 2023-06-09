import 'package:flutter/material.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/modules_util.dart';

class ModulesGridView extends StatelessWidget {
  const ModulesGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          primary: false,
          itemCount: ModulesUtil.listModulesMode.length,
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
                        height: MediaQuery.of(context).size.width * 0.11,
                        width: MediaQuery.of(context).size.width * 0.11),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.03),
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
    );
  }
}
