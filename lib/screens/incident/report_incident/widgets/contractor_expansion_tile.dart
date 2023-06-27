import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../../blocs/report_new_incident/report_new_incident_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class ContractorExpansionTile extends StatelessWidget {
  final String reportAnonymously;
  final String contractor;

  ContractorExpansionTile(
      {Key? key, required this.reportAnonymously, required this.contractor})
      : super(key: key);

  // List will be removed while implementing API.
  final List contractorList = [
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
                contractor == 'null'
                    ? StringConstants.kSelectContractor
                    : contractor,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contractorList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(contractorList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: contractorList[index],
                        groupValue: contractor,
                        onChanged: (value) {
                          value = contractorList[index];
                          context.read<ReportIncidentBloc>().add(
                              ReportIncidentScreenExpansionChange(
                                  reportAnonymously: reportAnonymously,
                                  contractor: value));
                        });
                  })
            ]));
  }
}
