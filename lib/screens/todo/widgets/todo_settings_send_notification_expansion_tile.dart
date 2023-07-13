import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class ToDoSettingsSendNotificationExpansionTile extends StatefulWidget {
  const ToDoSettingsSendNotificationExpansionTile({Key? key}) : super(key: key);

  static List settingsSendNotificationList = ['Yes', 'No'];
  static String sendNotificationElement = '';

  @override
  State<ToDoSettingsSendNotificationExpansionTile> createState() =>
      _ToDoSettingsSendNotificationExpansionTileState();
}

class _ToDoSettingsSendNotificationExpansionTileState
    extends State<ToDoSettingsSendNotificationExpansionTile> {
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
                (ToDoSettingsSendNotificationExpansionTile
                            .sendNotificationElement ==
                        '')
                    ? 'Select'
                    : ToDoSettingsSendNotificationExpansionTile
                        .sendNotificationElement,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ToDoSettingsSendNotificationExpansionTile
                      .settingsSendNotificationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding:
                            const EdgeInsets.only(left: xxxTinierSpacing),
                        activeColor: AppColor.deepBlue,
                        title: Text(
                            ToDoSettingsSendNotificationExpansionTile
                                .settingsSendNotificationList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: ToDoSettingsSendNotificationExpansionTile
                            .settingsSendNotificationList[index],
                        groupValue: ToDoSettingsSendNotificationExpansionTile
                            .sendNotificationElement,
                        onChanged: (value) {
                          setState(() {
                            value = ToDoSettingsSendNotificationExpansionTile
                                .settingsSendNotificationList[index];
                            ToDoSettingsSendNotificationExpansionTile
                                .sendNotificationElement = value;
                          });
                        });
                  })
            ]));
  }
}
