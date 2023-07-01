import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentRemoveLinkedPermit/incident_remove_linked_permit_bloc.dart';
import 'package:toolkit/blocs/incident/incidentRemoveLinkedPermit/incident_remove_linked_permit_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/text_button.dart';
import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../../blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import '../../../blocs/incident/incidentRemoveLinkedPermit/incident_remove_linked_permit_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incidents_list_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/progress_bar.dart';

class IncidentLinkPermitList extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final IncidentListDatum incidentListDatum;
  final int initialIndex;

  const IncidentLinkPermitList(
      {Key? key,
      required this.incidentDetailsModel,
      required this.incidentListDatum,
      required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            label: Row(
              children: [
                const Icon(Icons.add),
                const SizedBox(width: tiniestSpacing),
                Text(DatabaseUtil.getText('AddLinkToPermit'))
              ],
            ),
            onPressed: () {}),
        body: (incidentDetailsModel.data!.linkedpermits!.isEmpty)
            ? Center(
                child: Text(StringConstants.kNoILinkedPermit,
                    style: Theme.of(context).textTheme.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.mediumBlack)))
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: incidentDetailsModel.data!.linkedpermits!.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    child: ListTile(
                        contentPadding: const EdgeInsets.only(
                            left: tinierSpacing,
                            right: tinierSpacing,
                            top: tiniestSpacing,
                            bottom: tiniestSpacing),
                        trailing: BlocListener<IncidentRemoveLinkedPermitBloc,
                                IncidentRemoveLinkedPermitStates>(
                            listener: (context, state) {
                              if (state is IncidentRemoveLinkedPermitLoading) {
                                ProgressBar.show(context);
                              } else if (state is IncidentLinkedPermitRemoved) {
                                ProgressBar.dismiss(context);
                                context.read<IncidentDetailsBloc>().add(
                                    FetchIncidentDetailsEvent(
                                        incidentId: incidentListDatum.id,
                                        role: context
                                            .read<
                                                IncidentFetchAndChangeRoleBloc>()
                                            .roleId,
                                        incidentLinkIndex: initialIndex));
                              } else if (state
                                  is IncidentLinkedPermitNotRemoved) {
                                ProgressBar.dismiss(context);
                                showCustomSnackBar(context,
                                    StringConstants.kCannotUnlinkPermit, '');
                              }
                            },
                            child: CustomTextButton(
                                onPressed: () {
                                  context
                                      .read<IncidentRemoveLinkedPermitBloc>()
                                      .add(IncidentRemoveLinkedPermitEvent(
                                          permitId: incidentDetailsModel
                                              .data!.linkedpermits![index].id,
                                          permitLinkedList: incidentDetailsModel
                                              .data!.linkedpermits!,
                                          index: index));
                                },
                                textValue: 'Remove')),
                        title: Text(
                            incidentDetailsModel.data!.linkedpermits![index]
                                .processedPermitName,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTinierSpacing);
                },
              ));
  }
}
