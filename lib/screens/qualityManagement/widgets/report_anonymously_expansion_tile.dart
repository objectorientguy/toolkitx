import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';

class ReportAnonymouslyExpansionTile extends StatefulWidget {
  const ReportAnonymouslyExpansionTile({Key? key}) : super(key: key);

  @override
  State<ReportAnonymouslyExpansionTile> createState() =>
      _ReportAnonymouslyExpansionTileState();
}

class _ReportAnonymouslyExpansionTileState
    extends State<ReportAnonymouslyExpansionTile> {
  String options = StringConstants.kSelect;
  List reportList = ['Yes', 'No']; //This will change after API integration.

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title: Text(options, style: Theme.of(context).textTheme.xSmall),
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
                        groupValue: options,
                        onChanged: (value) {
                          setState(() {
                            value = reportList[index];
                            options = value;
                          });
                        });
                  })
            ]));
  }
}
