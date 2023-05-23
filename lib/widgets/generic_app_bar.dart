import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../configs/app_dimensions.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GenericAppBar(
      {Key? key,
      this.title,
      this.leading,
      this.actions,
      this.onPressedFunction})
      : super(key: key);
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final void Function()? onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title,
        titleTextStyle: Theme.of(context).textTheme.mediumLarge,
        leading: BackButton(onPressed: onPressedFunction),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
