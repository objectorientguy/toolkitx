import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';

class SiteExpansionTile extends StatefulWidget {
  const SiteExpansionTile({Key? key}) : super(key: key);

  @override
  State<SiteExpansionTile> createState() => _SiteExpansionTileState();
}

class _SiteExpansionTileState extends State<SiteExpansionTile> {
  String siteValue = StringConstants.kSelectSite;
  List siteValuesList = [
    'Other',
    'Berlin Office',
    'hamburg Control center',
    'Hamburg Office'
  ]; //This will change after API integration.

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          maintainState: true,
          key: GlobalKey(),
          title: Text(siteValue, style: Theme.of(context).textTheme.xSmall),
          children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: siteValuesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColor.deepBlue,
                      title: Text(siteValuesList[index],
                          style: Theme.of(context).textTheme.xSmall),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: siteValuesList[index],
                      groupValue: siteValue,
                      onChanged: (value) {
                        setState(() {
                          value = siteValuesList[index];
                          siteValue = value;
                        });
                      });
                })
          ]),
    );
  }
}
