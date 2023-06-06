import 'package:flutter/material.dart';

import '../configs/app_color.dart';

class PermitUtil {
  final List leadingAvatarList = [
    'assets/icons/human_avatar_four.png',
    'assets/icons/human_avatar_one.png',
    'assets/icons/human_avatar_two.png',
    'assets/icons/human_avatar_three.png'
  ];
  final List<Tab> tabBarViewIcons = [
    const Tab(
        icon: Icon(
      Icons.shelves,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.info,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.group,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.timeline,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.file_copy_sharp,
      color: AppColor.grey,
    )),
    const Tab(
        icon: Icon(
      Icons.chat,
      color: AppColor.grey,
    )),
  ];
}
