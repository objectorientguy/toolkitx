import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../../blocs/report_new_incident/report_new_incident_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';

class LocationExpansionTile extends StatelessWidget {
  final String site;
  final String location;
  final String reportToAuthorities;
  LocationExpansionTile(
      {Key? key,
      required this.site,
      required this.location,
      required this.reportToAuthorities})
      : super(key: key);

  // List will be removed while implementing API.
  final List locationList = [
    'Other',
    'DummyData1',
    'DummyData2',
    'DummyData3',
    'DummyData4',
    'DummyData5',
    'DummyData6',
  ];

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
            title: Text(
                location == 'null' ? StringConstants.kSelectLocation : location,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: locationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(locationList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: locationList[index],
                        groupValue: location,
                        onChanged: (value) {
                          value = locationList[index];
                          context.read<ReportIncidentBloc>().add(
                              LocationScreenExpansionChange(
                                  otherSite: site,
                                  otherLocation: value,
                                  reportToAuthorities: reportToAuthorities));
                        });
                  })
            ]));
  }
}
