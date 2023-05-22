import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class UserTypeExpansionTile extends StatefulWidget {
  const UserTypeExpansionTile({Key? key}) : super(key: key);

  @override
  State<UserTypeExpansionTile> createState() => _UserTypeExpansionTileState();
}

class _UserTypeExpansionTileState extends State<UserTypeExpansionTile> {
  String typeValue =
      'Select'; // This will be changed after QM gets merged into dev.
  final List userTypeList = [
    StringConstants.kWorkforce,
    StringConstants.kSystemUser
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: expansionTileMargin, right: expansionTileMargin),
            collapsedBackgroundColor: AppColor.offWhite,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text(typeValue, style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(userTypeList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: userTypeList[index],
                        groupValue: typeValue,
                        onChanged: (value) {
                          setState(() {
                            value = userTypeList[index];
                            typeValue = value;
                          });
                        });
                  })
            ]));
  }
}
