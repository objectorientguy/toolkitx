import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/qualityManagement/quality_management_events.dart';
import '../../../blocs/qualityManagement/quality_management_bloc.dart';
import '../../../configs/app_color.dart';

class ContractorExpansionTile extends StatelessWidget {
  final String contractorValue;
  final String reportValue;
  ContractorExpansionTile({
    Key? key,
    required this.contractorValue,
    required this.reportValue,
  }) : super(key: key);

  final List contractorList = [
    '35Sun',
    '50Hertz',
    'Acta Marine',
    'Angles Ltd 1',
    'Beurer GmbH'
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
                contractorValue == "null"
                    ? StringConstants.kSelectContractor
                    : contractorValue,
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
                        groupValue: contractorValue,
                        onChanged: (value) {
                          value = contractorList[index];
                          context.read<QualityManagementBloc>().add(
                              ReportQADropDown(
                                  reportValue: reportValue,
                                  contractorValue: value));
                        });
                  })
            ]));
  }
}
