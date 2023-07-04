import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/text_button.dart';

import '../configs/app_spacing.dart';

abstract class DatabaseUtil {
  static late final Box box;

  static String getText(String textValue) {
    if (box.get(textValue) != null) {
      String text = box.get(textValue);
      return text;
    }
    return '';
  }

  static Future<bool> showExitPopup(map1, map2, context) async {
    if (!mapEquals(map1, map2)) {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                StringConstants.kDiscardChanges,
                style: Theme.of(context).textTheme.medium,
              ),
              buttonPadding: const EdgeInsets.all(xxTiniestSpacing),
              contentPadding: const EdgeInsets.fromLTRB(
                  xxTinySpacing, xxTinySpacing, xxTinySpacing, 0),
              actionsPadding: const EdgeInsets.only(top: xxTinierSpacing),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  textValue: 'Yes',
                ),
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  textValue: 'No',
                ),
              ],
            ),
          ) ??
          false;
    } else {
      Navigator.pop(context);
    }
    return false;
  }
}
