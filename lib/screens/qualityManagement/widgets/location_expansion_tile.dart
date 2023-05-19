import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class LocationExpansionTile extends StatefulWidget {
  const LocationExpansionTile({Key? key}) : super(key: key);

  @override
  State<LocationExpansionTile> createState() => _LocationExpansionTileState();
}

class _LocationExpansionTileState extends State<LocationExpansionTile> {
  String locationValue = StringConstants.kSelectLocation;
  List locationValuesList = [
    'Other',
    'First Address',
    'Second Address',
    'Third Address'
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          maintainState: true,
          key: GlobalKey(),
          title: Text(locationValue, style: Theme.of(context).textTheme.xSmall),
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
                        setState(() {
                          value = locationValuesList[index];
                          locationValue = value;
                        });
                      });
                })
          ]),
    );
  }
}
