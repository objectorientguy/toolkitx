import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../utils/constants/string_constants.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = 'CategoryScreen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List selectedCategory = [];
  final List categoryList = [
    {
      'title': 'Assets',
      'items': ['spill/leak', 'Dispose']
    },
    {
      'title': 'Environment',
      'items': [
        'Restricted work',
        'fatality',
        'Adverse weather',
        'Air pollution',
        'Air pollution & emission'
      ]
    },
    {
      'title': 'Other',
      'items': ['Information', 'Process']
    },
    {
      'title': 'People',
      'items': ['Medical treatment']
    },
    {
      'title': 'Reputation',
      'items': ['Assets']
    }
  ]; // List will be removed while integrating API

  void checkBoxChange(bool isSelected, int index, int itemIndex) {
    setState(() {
      if (isSelected) {
        selectedCategory.add(categoryList[index]['items'][itemIndex]);
      } else {
        selectedCategory.remove(categoryList[index]['items'][itemIndex]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: Text(StringConstants.kCategory)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kSelectCategoryIncident,
              style: Theme.of(context)
                  .textTheme
                  .small
                  .copyWith(color: AppColor.black)),
          const SizedBox(height: tinySpacing),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(categoryList[index]['title'],
                              style: Theme.of(context).textTheme.small.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6A6D70))),
                          ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: categoryList[index]['items'].length,
                              itemBuilder:
                                  (BuildContext context, int itemIndex) {
                                return CheckboxListTile(
                                    checkColor: AppColor.white,
                                    activeColor: AppColor.deepBlue,
                                    contentPadding: EdgeInsets.zero,
                                    value: selectedCategory.contains(
                                        categoryList[index]['items']
                                            [itemIndex]),
                                    title: Text(
                                        categoryList[index]['items'][itemIndex],
                                        style:
                                            Theme.of(context).textTheme.small),
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    onChanged: (isChecked) {
                                      checkBoxChange(
                                          isChecked!, index, itemIndex);
                                    });
                              })
                        ]);
                  }))
        ]),
      ),
    );
  }
}
