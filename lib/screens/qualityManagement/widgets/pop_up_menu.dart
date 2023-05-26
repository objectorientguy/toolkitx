import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/qualityManagement/add_comments_screen.dart';
import 'package:toolkit/screens/qualityManagement/mark_as_resolved_screen.dart';
import 'package:toolkit/screens/qualityManagement/reporting_screen.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class CustomPopUpMenuButton extends StatefulWidget {
  const CustomPopUpMenuButton({Key? key}) : super(key: key);

  @override
  State<CustomPopUpMenuButton> createState() => _CustomPopUpMenuButtonState();
}

class _CustomPopUpMenuButtonState extends State<CustomPopUpMenuButton> {
  int popupMenuItemIndex =
      0; // This entire file will get refactored after API integration.
  List popUpMenuItems = [
    'Add Comments',
    'Edit',
    'View Logs',
    'Report',
    'Mark as resolved',
    'Generate PDF'
  ];

  PopupMenuItem _buildPopupMenuItem(context, String title, int position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  _onMenuItemSelected(int value) {
    setState(() {
      popupMenuItemIndex = value;
    });

    if (value == 0) {
      Navigator.pushNamed(context, AddCommentsScreen.routeName);
    } else if (value == 3) {
      Navigator.pushNamed(context, ReportingScreen.routeName);
    } else if (value == 4) {
      Navigator.pushNamed(context, MarkAsResolvedScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconSize: kIconSize,
        icon: const Icon(Icons.more_vert_outlined),
        offset: const Offset(0, midTiniestSpacing),
        onSelected: (value) {
          _onMenuItemSelected(value as int);
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              _buildPopupMenuItem(context, popUpMenuItems[0], 0),
              _buildPopupMenuItem(context, popUpMenuItems[1], 1),
              _buildPopupMenuItem(context, popUpMenuItems[2], 2),
              _buildPopupMenuItem(context, popUpMenuItems[3], 3),
              _buildPopupMenuItem(context, popUpMenuItems[4], 4),
              _buildPopupMenuItem(context, popUpMenuItems[5], 5)
            ]);
  }
}
