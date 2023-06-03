import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/edit_questions_screen.dart';
import '../../../../blocs/checklist/workforce/checklist_events.dart';
import '../../../../configs/app_spacing.dart';
import '../reject_reasons.dart';

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
        .read<WorkforceChecklistBloc>()
        .add(FetchPopUpMenuItems(popUpMenuItems: []));
    return BlocBuilder<WorkforceChecklistBloc, WorkforceChecklistStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WfPopUpMenuItemsFetched,
        builder: (context, state) {
          if (state is WfPopUpMenuItemsFetched) {
            return PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
                iconSize: kIconSize,
                icon: const Icon(Icons.more_vert_outlined),
                offset: const Offset(0, midTiniestSpacing),
                onSelected: (value) {
                  if (value == 'Edit') {
                    Navigator.pushNamed(
                      context,
                      EditQuestionsScreen.routeName,
                    );
                  }
                  if (value == 'Reject') {
                    Navigator.pushNamed(context, RejectReasonsScreen.routeName);
                  }
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) {
                  return List.generate(state.popUpMenuItems.length, (index) {
                    return _buildPopupMenuItem(
                        context,
                        state.popUpMenuItems[index],
                        state.popUpMenuItems[index]);
                  });
                });
          } else {
            return const SizedBox();
          }
        });
  }
}
