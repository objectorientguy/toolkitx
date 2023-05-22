import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class SeverityExpansionTile extends StatefulWidget {
  const SeverityExpansionTile({Key? key}) : super(key: key);

  @override
  State<SeverityExpansionTile> createState() => _SeverityExpansionTileState();
}

class _SeverityExpansionTileState extends State<SeverityExpansionTile> {
  String severityValue = StringConstants.kSelect;
  List severityValuesList = [
    'Not Severe',
    'Severe'
  ]; //This will change after API integration.

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          maintainState: true,
          key: GlobalKey(),
          title: Text(severityValue, style: Theme.of(context).textTheme.xSmall),
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: severityValuesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColor.deepBlue,
                      title: Text(severityValuesList[index],
                          style: Theme.of(context).textTheme.xSmall),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: severityValuesList[index],
                      groupValue: severityValue,
                      onChanged: (value) {
                        setState(() {
                          value = severityValuesList[index];
                          severityValue = value;
                        });
                      });
                })
          ]),
    );
  }
}
