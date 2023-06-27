import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../../blocs/report_new_incident/report_new_incident_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class ReportAnonymouslyExpansionTile extends StatelessWidget {
  final String reportAnonymously;
  final String contractor;

  ReportAnonymouslyExpansionTile(
      {Key? key,
      this.reportAnonymously = StringConstants.kNo,
      required this.contractor})
      : super(key: key);

  // List will be removed while implementing API.
  final List anonymous = [
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
            title: Text(reportAnonymously,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: anonymous.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(anonymous[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: anonymous[index],
                        groupValue: reportAnonymously,
                        onChanged: (value) {
                          value = anonymous[index];
                          context.read<ReportIncidentBloc>().add(
                              ReportIncidentScreenExpansionChange(
                                  reportAnonymously: value,
                                  contractor: contractor));
                        });
                  })
            ]));
  }
}
