import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';
import '../onboarding/widgets/custom_card.dart';

class ChangeRoleScreen extends StatefulWidget {
  static const routeName = 'ChangeRoleScreen';

  const ChangeRoleScreen({Key? key}) : super(key: key);

  @override
  State<ChangeRoleScreen> createState() => _ChangeRoleScreenState();
}

class _ChangeRoleScreenState extends State<ChangeRoleScreen> {
  String? changeRole;
  final List changeRoleList = [
    'Administrator',
    'HSE',
    'OCC',
    'Marine Coordination Center',
    'Service Department'
  ]; // This will be removed while API integration.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
          textValue: StringConstants.kChangeRole,
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
                        elevation: kZeroElevation,
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.only(bottom: tiniestSpacing),
                            shrinkWrap: true,
                            itemCount: changeRoleList.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height: largeSpacing,
                                  child: RadioListTile(
                                    dense: true,
                                    activeColor: AppColor.deepBlue,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(changeRoleList[index]),
                                    value: changeRoleList[index],
                                    groupValue: changeRole,
                                    onChanged: (value) {
                                      setState(() {
                                        changeRole = value;
                                      });
                                    },
                                  ));
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                  thickness: kDividerThickness,
                                  height: kDividerHeight);
                            })),
                    const SizedBox(height: mediumSpacing)
                  ])),
        ));
  }
}
