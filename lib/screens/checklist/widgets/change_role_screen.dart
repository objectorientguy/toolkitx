import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../onboarding/widgets/custom_card.dart';

class ChangeRoleScreen extends StatefulWidget {
  static const routeName = 'ChangeRoleScreen';

  const ChangeRoleScreen({Key? key}) : super(key: key);

  @override
  State<ChangeRoleScreen> createState() => _ChangeRoleScreenState();
}

class _ChangeRoleScreenState extends State<ChangeRoleScreen> {
  final List selectedItems = [];
  final List changeRoleList = [
    'Administrator',
    'HSE',
    'OCC',
    'Marine Coordination Center',
    'Service Department'
  ];

  void _itemChange(bool isSelected, int index) {
    setState(() {
      if (isSelected) {
        selectedItems.add(changeRoleList[index]);
      } else {
        selectedItems.remove(changeRoleList[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
          title: Text('Change Role'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: topBottomSpacing),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: tiniestSpacing),
                    CustomCard(
                        elevation: 0,
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.03),
                            shrinkWrap: true,
                            itemCount: changeRoleList.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: CheckboxListTile(
                                      dense: true,
                                      activeColor: AppColor.black,
                                      checkColor: AppColor.white,
                                      title: Text(
                                          changeRoleList[index].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall),
                                      value: selectedItems
                                          .contains(changeRoleList[index]),
                                      onChanged: (isChecked) {
                                        _itemChange(isChecked!, index);
                                      }));
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                  thickness: kDividerThickness,
                                  height: MediaQuery.of(context).size.width *
                                      0.062);
                            })),
                    const SizedBox(height: mediumSpacing),
                  ])),
        ));
  }
}
