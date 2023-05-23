import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../../blocs/report_new_incident/report_new_incident_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class ReportAuthoritiesExpansionTile extends StatelessWidget {
  final String site;
  final String location;
  final String reportToAuthorities;

  ReportAuthoritiesExpansionTile(
      {Key? key,
      required this.site,
      required this.location,
      this.reportToAuthorities = StringConstants.kNo})
      : super(key: key);

  // List will be removed while implementing API.
  final List reported = [
    StringConstants.kNo,
    StringConstants.kYes,
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: expansionTileMargin, right: expansionTileMargin),
            collapsedBackgroundColor: AppColor.white,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text(
                reportToAuthorities == 'null'
                    ? StringConstants.kNo
                    : reportToAuthorities,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: reported.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(reported[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: reported[index],
                        groupValue: reportToAuthorities,
                        onChanged: (value) {
                          value = reported[index];
                          context.read<ReportIncidentBloc>().add(
                              LocationScreenExpansionChange(
                                  otherSite: site,
                                  otherLocation: location,
                                  reportToAuthorities: value));
                        });
                  })
            ]));
  }
}
