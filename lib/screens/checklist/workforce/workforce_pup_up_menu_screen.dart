import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_edit_answer_list_screen.dart';
import '../../../../configs/app_spacing.dart';
import '../../../blocs/workforce/popUpMenu/workforce_pop_up_menu_bloc.dart';
import '../../../blocs/workforce/popUpMenu/workforce_pop_up_menu_events.dart';
import '../../../blocs/workforce/popUpMenu/workforce_pop_up_menu_states.dart';

class WorkForcePopUpMenu extends StatelessWidget {
  const WorkForcePopUpMenu({Key? key}) : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
      value: position,
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<PopUpMenuItemsBloc>()
        .add(FetchPopUpMenuItems(popUpMenuItems: []));
    return BlocBuilder<PopUpMenuItemsBloc, WfPopUpMenuItemsFetched>(
        builder: (context, state) {
      return PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          iconSize: kIconSize,
          icon: const Icon(Icons.more_vert_outlined),
          offset: const Offset(0, xxTinierSpacing),
          onSelected: (value) {
            if (value == 'Edit') {
              Navigator.pushNamed(
                context,
                EditAnswerListScreen.routeName,
              );
            }
            if (value == 'Reject') {
              // Navigator.pushNamed(context, RejectReasonsScreen.routeName);
            }
          },
          position: PopupMenuPosition.under,
          itemBuilder: (BuildContext context) {
            return List.generate(state.popUpMenuItems.length, (index) {
              return _buildPopupMenuItem(context, state.popUpMenuItems[index],
                  state.popUpMenuItems[index]);
            });
          });
    });
  }
}
