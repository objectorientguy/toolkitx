import 'package:flutter/material.dart';

class OnBoardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnBoardingAppBar({Key? key, this.title, this.leading, this.actions})
      : super(key: key);
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
