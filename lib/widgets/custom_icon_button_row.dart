import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';

class CustomIconButtonRow extends StatelessWidget {
  final IconData primaryIcon;
  final IconData secondaryIcon;
  final bool primaryVisible;
  final bool clearVisible;
  final bool secondaryVisible;
  final void Function() primaryOnPress;
  final void Function() clearOnPress;
  final void Function() secondaryOnPress;

  const CustomIconButtonRow(
      {Key? key,
      this.primaryIcon = Icons.filter_alt_outlined,
      this.secondaryIcon = Icons.settings_outlined,
      required this.primaryOnPress,
      required this.secondaryOnPress,
      this.primaryVisible = true,
      this.secondaryVisible = true,
      this.clearVisible = false,
      required this.clearOnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Visibility(
          visible: clearVisible,
          child: IconButton(
              constraints: const BoxConstraints(),
              onPressed: clearOnPress,
              icon: const Icon(Icons.filter_alt_off_outlined,
                  color: AppColor.grey))),
      Visibility(
          visible: primaryVisible,
          child: IconButton(
              constraints: const BoxConstraints(),
              onPressed: primaryOnPress,
              icon: Icon(primaryIcon, color: AppColor.grey))),
      Visibility(
          visible: secondaryVisible,
          child: IconButton(
              constraints: const BoxConstraints(),
              onPressed: secondaryOnPress,
              icon: Icon(secondaryIcon, color: AppColor.grey)))
    ]);
  }
}
