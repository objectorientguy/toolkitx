import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../data/enums/checklist_popup_menu_enum.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title) {
    return PopupMenuItem(
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
        iconSize: kIconSize,
        icon: const Icon(Icons.more_vert_outlined),
        constraints: BoxConstraints.expand(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.63),
        offset: Offset(50, MediaQuery.of(context).size.width * 0.025),
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              _buildPopupMenuItem(context,
                  ChecklistPopUpMenuItems.approve.popupItems.toString()),
              _buildPopupMenuItem(context,
                  ChecklistPopUpMenuItems.reject.popupItems.toString()),
              _buildPopupMenuItem(
                  context,
                  ChecklistPopUpMenuItems.thirdPartyApprove.popupItems
                      .toString()),
              _buildPopupMenuItem(context,
                  ChecklistPopUpMenuItems.editHeader.popupItems.toString()),
              _buildPopupMenuItem(context,
                  ChecklistPopUpMenuItems.cancel.popupItems.toString()),
            ]);
  }
}
