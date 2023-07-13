import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class ToDoSettingsSendMailExpansionTile extends StatefulWidget {
  const ToDoSettingsSendMailExpansionTile({Key? key}) : super(key: key);

  static List settingsSendmailList = ['Yes', 'No'];
  static String sendMailElement = '';

  @override
  State<ToDoSettingsSendMailExpansionTile> createState() =>
      _ToDoSettingsSendMailExpansionTileState();
}

class _ToDoSettingsSendMailExpansionTileState
    extends State<ToDoSettingsSendMailExpansionTile> {
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
                (ToDoSettingsSendMailExpansionTile.sendMailElement == '')
                    ? 'Select'
                    : ToDoSettingsSendMailExpansionTile.sendMailElement,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ToDoSettingsSendMailExpansionTile
                      .settingsSendmailList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding:
                            const EdgeInsets.only(left: xxxTinierSpacing),
                        activeColor: AppColor.deepBlue,
                        title: Text(
                            ToDoSettingsSendMailExpansionTile
                                .settingsSendmailList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: ToDoSettingsSendMailExpansionTile
                            .settingsSendmailList[index],
                        groupValue:
                            ToDoSettingsSendMailExpansionTile.sendMailElement,
                        onChanged: (value) {
                          setState(() {
                            value = ToDoSettingsSendMailExpansionTile
                                .settingsSendmailList[index];
                            ToDoSettingsSendMailExpansionTile.sendMailElement =
                                value;
                          });
                        });
                  })
            ]));
  }
}
