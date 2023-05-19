import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../data/enums/checklist_popup_menu_enum.dart';
import 'comments_popup.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  int popupMenuItemIndex = 0;

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

    if (value == ChecklistPopUpMenuItems.approve.index) {
      showDialog(
          context: context,
          builder: (context) {
            return const CommentsPopUp(textValue: StringConstants.kApprove);
          });
    } else if (value == ChecklistPopUpMenuItems.reject.index) {
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
        offset: Offset(0.0, MediaQuery.of(context).size.width * 0.025),
        onSelected: (value) {
          _onMenuItemSelected(value as int);
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              _buildPopupMenuItem(
                  context,
                  ChecklistPopUpMenuItems.approve.popupItems.toString(),
                  ChecklistPopUpMenuItems.approve.index),
              _buildPopupMenuItem(
                  context,
                  ChecklistPopUpMenuItems.reject.popupItems.toString(),
                  ChecklistPopUpMenuItems.reject.index),
              _buildPopupMenuItem(
                  context,
                  ChecklistPopUpMenuItems.thirdPartyApprove.popupItems
                      .toString(),
                  ChecklistPopUpMenuItems.thirdPartyApprove.index),
              _buildPopupMenuItem(
                  context,
                  ChecklistPopUpMenuItems.editHeader.popupItems.toString(),
                  ChecklistPopUpMenuItems.editHeader.index)
            ]);
  }
}
