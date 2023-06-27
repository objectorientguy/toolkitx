import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_color.dart';
import '../../utils/constants/string_constants.dart';
import 'widgets/custom_outlined_button.dart';
import 'widgets/pop_up_menu.dart';
import 'widgets/upload_alert_dialog.dart';

class QMDetailsScreen extends StatelessWidget {
  static const routeName = 'QMDetailsScreen';

  const QMDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
            title: Text(StringConstants.kDetails), actions: [QAPopupMenu()]),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('#RI0148',
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600)),
                            Text('CREATED',
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.deepBlue))
                          ]),
                      const SizedBox(height: tinySpacing),
                      Text(StringConstants.kReportedBy,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinySpacing),
                      Text('Pandora ITC, Sumit Workforce',
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinySpacing),
                      Text(StringConstants.kReportedDate,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinySpacing),
                      Text('08.05.2023',
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinySpacing),
                      Text(StringConstants.kLocation,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinySpacing),
                      Text('Berlin Office - 110X',
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinySpacing),
                      Text(StringConstants.kSeverityImpact,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinySpacing),
                      Text('Dummy Data',
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinySpacing),
                      Text(StringConstants.kAttachment,
                          style: Theme.of(context).textTheme.medium),
                      CustomOutlinedButton(onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => UploadAlertDialog(
                                onCamera: () {}, onDevice: () {}));
                      }),
                      Text(StringConstants.kIncidentDetails,
                          style: Theme.of(context).textTheme.medium),
                      const SizedBox(height: tinySpacing),
                      Text('Dummy Data',
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinySpacing),
                      Text(StringConstants.kAttachment,
                          style: Theme.of(context).textTheme.medium),
                      CustomOutlinedButton(onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => UploadAlertDialog(
                                onCamera: () {}, onDevice: () {}));
                      })
                    ]))));
  }
}
