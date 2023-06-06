import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';

class FilterStatusExpansionTile extends StatefulWidget {
  const FilterStatusExpansionTile({Key? key}) : super(key: key);

  @override
  State<FilterStatusExpansionTile> createState() =>
      _FilterStatusExpansionTileState();
}

class _FilterStatusExpansionTileState extends State<FilterStatusExpansionTile> {
  String status = '';
  List selectedStatus = [];

  // List will be removed while implementing API.
  List filterStatus = [
    "Created",
    "Reported",
    "Acknowledged",
    "Mitigation Defined",
    "Mitigation Approved"
  ];

  void checkBoxChange(bool isSelected, int index) {
    setState(() {
      if (isSelected) {
        selectedStatus.add(filterStatus[index]);
      } else {
        selectedStatus.remove(filterStatus[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            maintainState: true,
            title: Text((status == '') ? StringConstants.kSelectStatus : status,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filterStatus.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                        checkColor: AppColor.white,
                        activeColor: AppColor.deepBlue,
                        contentPadding: EdgeInsets.zero,
                        value: selectedStatus.contains(filterStatus[index]),
                        title: Text(filterStatus[index]),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) {
                          checkBoxChange(isChecked!, index);
                          status = selectedStatus
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '');
                        });
                  })
            ]));
  }
}
