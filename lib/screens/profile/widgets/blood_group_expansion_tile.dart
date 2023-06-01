import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/blood_group_enum.dart';
import '../../../utils/constants/string_constants.dart';

class BloodGroupExpansionTile extends StatefulWidget {
  const BloodGroupExpansionTile({Key? key}) : super(key: key);

  @override
  State<BloodGroupExpansionTile> createState() =>
      _BloodGroupExpansionTileState();
}

class _BloodGroupExpansionTileState extends State<BloodGroupExpansionTile> {
  String? bloodGroup;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: kExpansionTileMargin, right: kExpansionTileMargin),
            collapsedBackgroundColor: AppColor.white,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text(
                bloodGroup == null
                    ? StringConstants.kSelectBloodGroup
                    : bloodGroup!,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: BloodGroup.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(
                            BloodGroup.values.elementAt(index).bloodGroup,
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: BloodGroup.values.elementAt(index).bloodGroup,
                        groupValue: bloodGroup,
                        onChanged: (value) {
                          setState(() {
                            value =
                                BloodGroup.values.elementAt(index).bloodGroup;
                            bloodGroup = value;
                          });
                        });
                  })
            ]));
  }
}
