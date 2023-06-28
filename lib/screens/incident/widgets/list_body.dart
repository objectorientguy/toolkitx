import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/incident/incident_details_screen.dart';
import '../../../blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import '../../../blocs/incident/incidentList/incident_list_bloc.dart';
import '../../../blocs/incident/incidentList/incident_list_event.dart';
import '../../../blocs/incident/incidentList/incident_list_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/error_section.dart';
import 'incident_list_subtitle.dart';
import 'incident_list_title.dart';

class IncidentListBody extends StatelessWidget {
  const IncidentListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncidentListBloc, IncidentListStates>(
        builder: (context, state) {
      if (state is FetchingIncidents) {
        return Center(
            child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                child: const CircularProgressIndicator()));
      } else if (state is IncidentsFetched) {
        return Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.fetchIncidentsListModel.data!.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                      child: ListTile(
                    contentPadding: const EdgeInsets.all(xxTinierSpacing),
                    title: IncidentListTitle(
                        incidentListDatum:
                            state.fetchIncidentsListModel.data![index]),
                    subtitle: IncidentListSubtitle(
                        incidentListDatum:
                            state.fetchIncidentsListModel.data![index]),
                    onTap: () {
                      Navigator.pushNamed(
                          context, IncidentDetailsScreen.routeName,
                          arguments:
                              state.fetchIncidentsListModel.data![index]);
                    },
                  ));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTinySpacing);
                }));
      } else if (state is IncidentsNotFetched) {
        return GenericReloadButton(
            onPressed: () {
              context.read<IncidentListBloc>().add(FetchIncidentListEvent(
                  roleId:
                      context.read<IncidentFetchAndChangeRoleBloc>().roleId));
            },
            textValue: StringConstants.kReload);
      } else {
        return const SizedBox();
      }
    });
  }
}
