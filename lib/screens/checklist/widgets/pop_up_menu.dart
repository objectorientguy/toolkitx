import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import 'comments_popup.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  int popupMenuItemIndex = 0;

  // This entire file will get refactored after API integration.
  List popUpMenuItems = [
    'Approve',
    'Reject',
    'Third Party Approve',
    'Edit Header'
  ];

  PopupMenuItem _buildPopupMenuItem(context, String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      popupMenuItemIndex = value;
    });

    if (value == 0) {
      showDialog(
          context: context,
          builder: (context) {
            return const CommentsPopUp(textValue: StringConstants.kApprove);
          });
    } else if (value == 1) {
      showDialog(
          context: context,
          builder: (context) {
            return const CommentsPopUp(textValue: StringConstants.kReject);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
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
              _buildPopupMenuItem(context, popUpMenuItems[3], 3)
            ]);
  }
}
