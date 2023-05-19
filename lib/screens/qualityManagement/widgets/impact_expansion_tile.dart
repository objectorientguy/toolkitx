import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class ImpactExpansionTile extends StatefulWidget {
  const ImpactExpansionTile({Key? key}) : super(key: key);

  @override
  State<ImpactExpansionTile> createState() => _ImpactExpansionTileState();
}

class _ImpactExpansionTileState extends State<ImpactExpansionTile> {
  String impactValue = StringConstants.kSelect;
  List impactValuesList = ['Low', 'High', 'Medium'];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          maintainState: true,
          key: GlobalKey(),
          title: Text(impactValue, style: Theme.of(context).textTheme.xSmall),
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
                        setState(() {
                          value = impactValuesList[index];
                          impactValue = value;
                        });
                      });
                })
          ]),
    );
  }
}
