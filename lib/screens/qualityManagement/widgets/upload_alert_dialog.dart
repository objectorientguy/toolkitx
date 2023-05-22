import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../utils/constants/string_constants.dart';

class UploadAlertDialog extends StatelessWidget {
  final void Function() onCamera;
  final void Function() onDevice;

  const UploadAlertDialog(
      {Key? key, required this.onCamera, required this.onDevice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius),
            side: const BorderSide(color: AppColor.black)),
        actions: [
          Center(
              child: Text(StringConstants.kUploadFrom,
                  style: Theme.of(context).textTheme.medium)),
          const SizedBox(height: tiniestSpacing),
          IntrinsicHeight(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                    padding: const EdgeInsets.all(midTiniestSpacing),
                    child: Column(children: [
                      InkWell(
                          onTap: onCamera,
                          borderRadius:
                              BorderRadius.circular(kAlertDialogRadius),
                          child: Container(
                              width: kAlertDialogTogether,
                              height: kAlertDialogTogether,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(
                                      kAlertDialogRadius)),
                              child: const Center(
                                  child: Icon(Icons.camera_alt_outlined,
                                      size: kAlertDialogIconSize)))),
                      const SizedBox(height: tiniestSpacing),
                      const Text(
                        StringConstants.kCamera,
                      )
                    ])),
                const VerticalDivider(
                    color: Colors.grey,
                    width: kDividerWidth,
                    thickness: kDividerThickness,
                    indent: kDividerIndent,
                    endIndent: kDividerEndIndent),
                Padding(
                    padding: const EdgeInsets.all(midTiniestSpacing),
                    child: Column(children: [
                      InkWell(
                        onTap: onDevice,
                        child: Container(
                          width: kAlertDialogTogether,
                          height: kAlertDialogTogether,
                          decoration: BoxDecoration(
                              color: AppColor.ghostWhite,
                              borderRadius:
                                  BorderRadius.circular(kAlertDialogRadius)),
                          child: const Center(
                              child: Icon(
                            Icons.drive_folder_upload,
                            size: kAlertDialogIconSize,
                          )),
                        ),
                      ),
                      const SizedBox(height: tiniestSpacing),
                      Text(StringConstants.kDevice,
                          style: Theme.of(context)
                              .textTheme
                              .small
                              .copyWith(color: AppColor.black))
                    ]))
              ]))
        ]);
  }
}
