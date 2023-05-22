import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/qualityManagement/quality_management_bloc.dart';
import '../../../blocs/qualityManagement/quality_management_events.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class ImpactExpansionTile extends StatelessWidget {
  final String siteValue;
  final String locationValue;
  final String severityValue;
  final String impactValue;

  ImpactExpansionTile(
      {Key? key,
      required this.siteValue,
      required this.locationValue,
      required this.severityValue,
      required this.impactValue})
      : super(key: key);

  final List impactValuesList = [
    'Low',
    'High',
    'Medium'
  ]; //This will change after API integration.
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          maintainState: true,
          key: GlobalKey(),
          title: Text(
              impactValue == "null" ? StringConstants.kSelect : impactValue,
              style: Theme.of(context).textTheme.xSmall),
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: impactValuesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColor.deepBlue,
                      title: Text(impactValuesList[index],
                          style: Theme.of(context).textTheme.xSmall),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: impactValuesList[index],
                      groupValue: impactValue,
                      onChanged: (value) {
                        value = impactValuesList[index];
                        context.read<QualityManagementBloc>().add(
                            ReportingQADropDown(
                                siteValue: siteValue,
                                locationValue: locationValue,
                                severityValue: severityValue,
                                impactValue: value));
                      });
                })
          ]),
    );
  }
}
