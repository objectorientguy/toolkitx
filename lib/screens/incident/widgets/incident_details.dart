import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import 'package:toolkit/screens/incident/widgets/view_incident_details_network_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../configs/app_color.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/database_utils.dart';

class IncidentDetails extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final List fileNames;
  final String fileRandomValue;

  const IncidentDetails(
      {Key? key,
      required this.incidentDetailsModel,
      required this.fileNames,
      required this.fileRandomValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniest),
            Text(
              DatabaseUtil.getText('Reportedby'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(
                '${incidentDetailsModel.data!.companyname} - ${incidentDetailsModel.data!.createdbyname}'),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('ReportedDate'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.eventdatetime,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('Category'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.categorynames,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('IncidentDetails'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.description,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('Location'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.locationname,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: xxTinierSpacing),
            ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: incidentDetailsModel.data!.maplinks!.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTinierSpacing);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        launchUrlString(
                            incidentDetailsModel.data!.maplinks![index].link,
                            mode: LaunchMode.inAppWebView);
                      },
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        softWrap: true,
                        maxLines: 2,
                        textScaleFactor: 1,
                        text: TextSpan(
                          text:
                              "${incidentDetailsModel.data!.maplinks![index].name} : ",
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: incidentDetailsModel
                                    .data!.maplinks![index].link,
                                style:
                                    Theme.of(context).textTheme.xSmall.copyWith(
                                          color: AppColor.deepBlue,
                                        )),
                          ],
                        ),
                      ));
                }),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('Reportedauthority'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.responsiblePerson,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('ReportedDate'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.reporteddatetime,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('viewimage'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Visibility(
              visible: incidentDetailsModel.data!.files.isNotEmpty,
              child: ViewIncidentDetailsNetworkImage(
                onTap: () {
                  launchUrlString(
                      '${ApiConstants.viewDocBaseUrl}${fileNames[0]}&code=$fileRandomValue',
                      mode: LaunchMode.inAppWebView);
                },
                imageUrl:
                    '${ApiConstants.viewDocBaseUrl}${fileNames[0]}&code=$fileRandomValue',
                itemCount: fileNames.length,
              ),
            ),
            const SizedBox(height: tiny)
          ],
        ));
  }
}
