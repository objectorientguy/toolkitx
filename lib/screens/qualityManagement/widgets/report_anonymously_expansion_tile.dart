import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/qualityManagement/quality_management_events.dart';
import '../../../blocs/qualityManagement/quality_management_bloc.dart';
import '../../../configs/app_color.dart';

class ReportAnonymouslyExpansionTile extends StatelessWidget {
  final String reportValue;
  final String contractorValue;

  ReportAnonymouslyExpansionTile(
      {Key? key, required this.reportValue, required this.contractorValue})
      : super(key: key);

  final List reportList = [
    'Yes',
    'No'
  ]; //This will change after API integration.
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title: Text(
                reportValue == "null" ? StringConstants.kSelect : reportValue,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(reportList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: reportList[index],
                        groupValue: reportValue,
                        onChanged: (value) {
                          value = reportList[index];
                          context.read<QualityManagementBloc>().add(
                              ReportQADropDown(
                                  reportValue: value,
                                  contractorValue: contractorValue));
                        });
                  })
            ]));
  }
}
