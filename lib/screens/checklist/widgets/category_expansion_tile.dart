import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class CategoryExpansionTile extends StatefulWidget {
  const CategoryExpansionTile({Key? key}) : super(key: key);

  @override
  State<CategoryExpansionTile> createState() => _CategoryExpansionTileState();
}

class _CategoryExpansionTileState extends State<CategoryExpansionTile> {
  String? category;
  final List changeRoleList = [
    'Electric Safety',
    'Production',
    'Pune',
    'Steel Inspect',
    'Testing'
  ]; // This code will be changed after API integration.
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
                category == null ? StringConstants.kSelectCategory : category!,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: changeRoleList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(changeRoleList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: changeRoleList[index],
                        groupValue: category,
                        onChanged: (value) {
                          setState(() {
                            value = changeRoleList[index];
                            category = value;
                          });
                        });
                  })
            ]));
  }
}
