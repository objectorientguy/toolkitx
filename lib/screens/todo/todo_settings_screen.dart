import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_spacing.dart';
import '../../widgets/primary_button.dart';
import 'widgets/todo_settings_send_mail_expansion_tile.dart';
import 'widgets/todo_settings_send_notification_expansion_tile.dart';

class ToDoSettingsScreen extends StatelessWidget {
  static const routeName = 'ToDoSettingsScreen';

  const ToDoSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Settings')),
      bottomNavigationBar: BottomAppBar(
        child: PrimaryButton(
            onPressed: () {}, textValue: DatabaseUtil.getText('buttonSave')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DatabaseUtil.getText('SendemailafterToDoassigned'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            const ToDoSettingsSendMailExpansionTile(),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('SendnotificationafterToDocompleted'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            const ToDoSettingsSendNotificationExpansionTile()
          ],
        ),
      ),
    );
  }
}
