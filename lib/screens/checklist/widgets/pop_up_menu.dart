import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checklist_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/checklist_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/widgets/reject_popup.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../systemUser/edit_header_screen.dart';
import 'approve_popup.dart';

class PopUpMenu extends StatelessWidget {
  final List scheduleIdList;
  final String scheduleId;
  final bool popUpMenuBuilder;

  const PopUpMenu(
      {Key? key,
      required this.scheduleIdList,
      required this.scheduleId,
      required this.popUpMenuBuilder})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
      value: position,
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChecklistBloc>().add(
        FetchPopUpMenu(popUpMenuItems: [], popUpMenuBuilder: popUpMenuBuilder));
    return BlocBuilder<ChecklistBloc, ChecklistStates>(
        buildWhen: (previousState, currentState) =>
            currentState is PopUpMenuItemsFetched,
        builder: (context, state) {
          if (state is PopUpMenuItemsFetched) {
            return PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
                iconSize: kIconSize,
                icon: const Icon(Icons.more_vert_outlined),
                offset: const Offset(0, midTiniestSpacing),
                onSelected: (value) {
                  if (value == 'Approve') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ApprovePopUp(
                              textValue: StringConstants.kApprove,
                              scheduleIdList: scheduleIdList);
                        });
                  }
                  if (value == 'Reject') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return RejectPopUp(
                              textValue: StringConstants.kReject,
                              scheduleIdList: scheduleIdList);
                        });
                  }
                  if (value == 'Third Party Approve') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return RejectPopUp(
                              textValue: StringConstants.kReject,
                              scheduleIdList: scheduleIdList);
                        });
                  }
                  if (value == 'Edit Header') {
                    Navigator.pushNamed(context, EditHeaderScreen.routeName,
                        arguments: scheduleId);
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
