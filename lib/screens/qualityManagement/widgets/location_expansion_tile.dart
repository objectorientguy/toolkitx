import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/qualityManagement/quality_management_bloc.dart';
import '../../../blocs/qualityManagement/quality_management_events.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class LocationExpansionTile extends StatelessWidget {
  final String siteValue;
  final String locationValue;
  final String severityValue;
  final String impactValue;

  LocationExpansionTile(
      {Key? key,
      required this.siteValue,
      required this.locationValue,
      required this.severityValue,
      required this.impactValue})
      : super(key: key);

  final List locationValuesList = [
    'Other',
    'First Address',
    'Second Address',
    'Third Address'
  ];

  //This will change after API integration.
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          maintainState: true,
          key: GlobalKey(),
          title: Text(
              locationValue == "null"
                  ? StringConstants.kSelectLocation
                  : locationValue,
              style: Theme.of(context).textTheme.xSmall),
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: locationValuesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColor.deepBlue,
                      title: Text(locationValuesList[index],
                          style: Theme.of(context).textTheme.xSmall),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: locationValuesList[index],
                      groupValue: locationValue,
                      onChanged: (value) {
                        value = locationValuesList[index];
                        context.read<QualityManagementBloc>().add(
                            ReportingQADropDown(
                                siteValue: siteValue,
                                locationValue: value,
                                severityValue: severityValue,
                                impactValue: impactValue));
                      });
                })
          ]),
    );
  }
}
