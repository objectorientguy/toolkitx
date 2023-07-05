import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class IncidentSiteList extends StatelessWidget {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectSiteName;

  const IncidentSiteList(
      {Key? key,
      required this.fetchIncidentMasterModel,
      required this.selectSiteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectSite),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(top: topBottomPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding:
                            const EdgeInsets.only(bottom: xxTiniestSpacing),
                        shrinkWrap: true,
                        itemCount: fetchIncidentMasterModel
                            .incidentMasterDatum![0].length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: xxxMediumSpacing,
                              child: RadioListTile(
                                  activeColor: AppColor.deepBlue,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  title: Text(fetchIncidentMasterModel
                                      .incidentMasterDatum![0][index].name!),
                                  value: fetchIncidentMasterModel
                                      .incidentMasterDatum![0][index].name!,
                                  groupValue: selectSiteName,
                                  onChanged: (value) {
                                    value = fetchIncidentMasterModel
                                        .incidentMasterDatum![0][index].name!;
                                    context
                                        .read<ReportNewIncidentBloc>()
                                        .add(ReportIncidentSiteListChange(
                                          selectSiteName:
                                              fetchIncidentMasterModel
                                                  .incidentMasterDatum![0]
                                                      [index]
                                                  .name!,
                                        ));
                                    Navigator.pop(context);
                                  }));
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
