import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_state.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/error_section.dart';

class IncidentListSection extends StatelessWidget {
  const IncidentListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<IncidentLisAndFilterBloc, IncidentListAndFilterStates>(
          builder: (context, state) {
            if (state is FetchingIncidents) {
              return const CircularProgressIndicator();
            } else if (state is IncidentsFetched) {
              if (state.fetchIncidentsListModel.data!.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.fetchIncidentsListModel.data!.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                contentPadding:
                                    const EdgeInsets.all(xxTinierSpacing),
                                title: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: xxTinierSpacing),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              state.fetchIncidentsListModel
                                                  .data![index].refno,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .small
                                                  .copyWith(
                                                      color: AppColor.black,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          Text(
                                              state.fetchIncidentsListModel
                                                  .data![index].status,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .xxSmall
                                                  .copyWith(
                                                      color: AppColor.deepBlue))
                                        ])),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          state.fetchIncidentsListModel
                                              .data![index].description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall),
                                      const SizedBox(height: tiniestSpacing),
                                      Text(
                                          state.fetchIncidentsListModel
                                              .data![index].location,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)),
                                      const SizedBox(height: xxTinierSpacing),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/icons/calendar.png",
                                              height: kIconSize,
                                              width: kIconSize),
                                          const SizedBox(width: tiniestSpacing),
                                          Text(
                                              state.fetchIncidentsListModel
                                                  .data![index].eventdatetime,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .xSmall
                                                  .copyWith(
                                                      color: AppColor.grey)),
                                        ],
                                      )
                                    ])));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: xxTinySpacing);
                      }),
                );
              } else {
                if (state.filterMap.isEmpty) {
                  return Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.5),
                          child:
                              Text(DatabaseUtil.getText('no_records_found'))));
                } else {
                  return Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.5),
                          child: const Text(StringConstants.kNoRecordsFilter)));
                }
              }
            } else if (state is IncidentsNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context.read<IncidentLisAndFilterBloc>().add(
                        FetchIncidentListEvent(
                            isFromHome: false,
                            roleId: context
                                .read<IncidentFetchAndChangeRoleBloc>()
                                .roleId));
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    ));
  }
}
