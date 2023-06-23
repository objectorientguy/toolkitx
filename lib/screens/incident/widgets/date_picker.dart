import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/text_button.dart';

typedef StringCallBack = Function(String date);

class DatePickerTextField extends StatelessWidget {
  final DateTime? initialDate;
  final StringCallBack onDateChanged;
  final DateTime? maxDate;
  final String editDate;
  final String? hintText;
  final DateTime? minimumDate;
  final TextEditingController dateInputController = TextEditingController();
  late final bool? isFirstTime;

  DatePickerTextField({
    Key? key,
    this.initialDate,
    this.maxDate,
    this.editDate = '',
    this.hintText,
    this.minimumDate,
    this.isFirstTime = true,
    required this.onDateChanged,
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
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: (isFirstTime != false)
                                ? initialDate
                                : DateFormat("dd MMM yyyy")
                                    .parse(dateInputController.text),
                            onDateTimeChanged: (value) {
                              String formattedDate =
                                  DateFormat('dd MMM yyyy').format(value);
                              dateInputController.text = formattedDate;
                              isFirstTime = false;
                            },
                            maximumDate: maxDate)),
                    CustomTextButton(
                        onPressed: () {
                          if (isFirstTime != false) {
                            if (initialDate == null) {
                              dateInputController.text =
                                  DateFormat('dd MMM yyyy')
                                      .format(DateTime.now());
                            } else {
                              dateInputController.text =
                                  DateFormat('dd MMM yyyy')
                                      .format(initialDate!);
                            }
                          }
                          Navigator.pop(context);
                        },
                        textValue: DatabaseUtil.getText('buttonDone'))
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: true,
        controller: dateInputController,
        onChanged: (value) {
          onDateChanged(value);
        },
        onTap: () async {
          showDatePicker(context);
        },
        cursorColor: AppColor.black,
        decoration: InputDecoration(
            hintStyle: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(xxTinierSpacing),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            filled: true,
            fillColor: AppColor.white));
  }
}
