import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../../blocs/incident/incidentListAndFilter/incident_list_and_filter_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../incident_details_screen.dart';
import '../incident_list_screen.dart';
import 'incident_list_subtitle.dart';
import 'incident_list_title.dart';

class IncidentListBody extends StatefulWidget {
  static bool noMoreData = false;
  static List incidentListData = [];

  const IncidentListBody({Key? key}) : super(key: key);

  @override
  State<IncidentListBody> createState() => _IncidentListBodyState();
}

class _IncidentListBodyState extends State<IncidentListBody> {
  var controller = ScrollController(keepScrollOffset: true);
  static bool waitForData = false;

  @override
  void initState() {
    IncidentListScreen.page = 1;
    IncidentListBody.noMoreData = false;
    IncidentListBody.incidentListData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncidentLisAndFilterBloc, IncidentListAndFilterStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is IncidentsFetched &&
                    IncidentListBody.noMoreData != true) ||
                (currentState is FetchingIncidents &&
                    IncidentListScreen.page == 1)),
        listener: (context, state) {
          if (state is FetchingIncidents) {}
          if (state is IncidentsFetched) {
            if (state.fetchIncidentsListModel.status == 204 &&
                IncidentListScreen.page != 1) {
              IncidentListBody.noMoreData = true;
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingIncidents) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          } else if (state is IncidentsFetched) {
            if (state.fetchIncidentsListModel.data!.isNotEmpty) {
              for (var item in state.fetchIncidentsListModel.data!) {
                IncidentListBody.incidentListData.add(item);
              }
              waitForData = false;
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      controller: controller
                        ..addListener(() {
                          if (IncidentListBody.noMoreData != true &&
                              waitForData == false) {
                            if (controller.position.extentAfter < 500) {
                              IncidentListScreen.page++;
                              context.read<IncidentLisAndFilterBloc>().add(
                                  FetchIncidentListEvent(
                                      isFromHome: false,
                                      page: IncidentListScreen.page));
                              waitForData = true;
                            }
                          }
                        }),
                      shrinkWrap: true,
                      itemCount: IncidentListBody.incidentListData.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                contentPadding:
                                    const EdgeInsets.all(xxTinierSpacing),
                                title: IncidentListTitle(
                                    incidentListDatum: IncidentListBody
                                        .incidentListData[index]),
                                subtitle: IncidentListSubtitle(
                                    incidentListDatum: IncidentListBody
                                        .incidentListData[index]),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, IncidentDetailsScreen.routeName,
                                      arguments: IncidentListBody
                                          .incidentListData[index]);
                                }));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: xxTinySpacing);
                      }));
            } else {
              if (state.fetchIncidentsListModel.status == 204) {
                if (state.filterMap.isEmpty) {
                  return const NoRecordsText(
                      text: StringConstants.kNoRecordsFilter);
                } else {
                  return NoRecordsText(
                      text: DatabaseUtil.getText('no_records_found'));
                }
              } else {
                return const SizedBox();
              }
            }
          } else {
            return const SizedBox();
          }
        });
  }
}
