import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/text_button.dart';

typedef TimeCallBack = Function(String timePicked);

class TimePickerTextField extends StatelessWidget {
  final DateTime? initialDateTime;
  final String editTime;
  final String? hintText;
  final DateTime? minimumTime;
  final TextEditingController timeInputController = TextEditingController();
  bool? isFirstTime;
  final TimeCallBack onTimePicked;

  TimePickerTextField({
    Key? key,
    this.initialDateTime,
    this.editTime = '',
    this.hintText,
    this.minimumTime,
    this.isFirstTime = true,
    required this.onTimePicked,
  }) : super(key: key);

  void showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: kDateTimePickerContainerHeight,
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: kDateTimePickerHeight,
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            use24hFormat: true,
                            initialDateTime: (isFirstTime != false)
                                ? initialDateTime
                                : DateFormat("HH:mm")
                                    .parse(timeInputController.text),
                            onDateTimeChanged: (value) {
                              String formattedDate =
                                  DateFormat("HH:mm").format(value);
                              timeInputController.text = formattedDate;
                              isFirstTime = false;
                              onTimePicked(timeInputController.text);
                            },
                            minuteInterval: 1)),
                    CustomTextButton(
                        onPressed: () {
                          if (isFirstTime != false) {
                            if (initialDateTime == null) {
                              timeInputController.text =
                                  DateFormat('HH.mm').format(DateTime.now());
                              onTimePicked(timeInputController.text);
                            } else {
                              timeInputController.text =
                                  DateFormat('HH.mm').format(initialDateTime!);
                              onTimePicked(timeInputController.text);
                            }
                          }
                          Navigator.pop(context);
                        },
                        textValue: StringConstants.kDone)
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: true,
        controller: timeInputController,
        onChanged: (value) {},
        onTap: () async {
          showDatePicker(context);
          onTimePicked(timeInputController.text);
        },
        cursorColor: AppColor.black,
        decoration: InputDecoration(
            hintStyle: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(midTiniestSpacing),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            filled: true,
            fillColor: AppColor.white));
  }
}
