import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/quality_management_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/qualityManagement/quality_management_bloc.dart';
import '../../../configs/app_color.dart';

class SiteExpansionTile extends StatelessWidget {
  final String siteValue;
  final String locationValue;
  final String severityValue;
  final String impactValue;

  SiteExpansionTile(
      {Key? key,
      required this.siteValue,
      required this.locationValue,
      required this.severityValue,
      required this.impactValue})
      : super(key: key);
  final List siteValuesList = [
    'Other',
    'Berlin Office',
    'hamburg Control center',
    'Hamburg Office'
  ]; //This will change after API integration.
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          maintainState: true,
          key: GlobalKey(),
          title: Text(
              siteValue == 'null' ? StringConstants.kSelectSite : siteValue,
              style: Theme.of(context).textTheme.xSmall),
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: siteValuesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColor.deepBlue,
                      title: Text(siteValuesList[index],
                          style: Theme.of(context).textTheme.xSmall),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: siteValuesList[index],
                      groupValue: siteValue,
                      onChanged: (value) {
                        value = siteValuesList[index];
                        context.read<QualityManagementBloc>().add(
                            ReportingQADropDown(
                                siteValue: value,
                                locationValue: locationValue,
                                severityValue: severityValue,
                                impactValue: impactValue));
                      });
                })
          ]),
    );
  }
}
