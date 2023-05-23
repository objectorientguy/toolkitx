import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class HealthSafetyExpansionTile extends StatelessWidget {
  final String selectedData;
  HealthSafetyExpansionTile({Key? key, required this.selectedData})
      : super(key: key);

  final List healthSafetyList = [
    '1. DummyData1',
    '2. DummyData2',
    '3. DummyData3',
    '4. DummyData4',
    '5. DummyData5'
  ];

  // List will be removed while implementing API.
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
                (selectedData == 'null')
                    ? StringConstants.kSelect
                    : selectedData,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: healthSafetyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(healthSafetyList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: healthSafetyList[index],
                        groupValue: selectedData,
                        onChanged: (value) {
                          value = healthSafetyList[index];
                          context
                              .read<ReportIncidentBloc>()
                              .add(HealthData(healthData: value));
                        });
                  })
            ]));
  }
}
