import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class SiteExpansionTile extends StatelessWidget {
  final String site;
  final String location;
  final String reportToAuthorities;

  SiteExpansionTile(
      {Key? key,
      required this.site,
      required this.location,
      required this.reportToAuthorities})
      : super(key: key);

  final List siteList = [
    'Other',
    'DummyData1',
    'DummyData2',
    'DummyData3',
    'DummyData4',
    'DummyData5',
    'DummyData6',
  ]; // List will be removed while implementing API.
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: expansionTileMargin, right: expansionTileMargin),
            key: GlobalKey(),
            collapsedBackgroundColor: AppColor.white,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            title: Text(site == 'null' ? StringConstants.kSelectSite : site,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: siteList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(siteList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: siteList[index],
                        groupValue: site,
                        onChanged: (value) {
                          value = siteList[index];
                          context.read<ReportIncidentBloc>().add(
                              LocationScreenExpansionChange(
                                  otherSite: value,
                                  otherLocation: location,
                                  reportToAuthorities: reportToAuthorities));
                        });
                  })
            ]));
  }
}
