import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../../blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_bloc.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_event.dart';
import '../../../blocs/incident/incidentInjuryDetails/incident_injury_details_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incidents_list_model.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import 'add_injured_person_body.dart';
import 'incident_injured_person_list.dart';

class IncidentInjuredPersonTab extends StatefulWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final int initialIndex;
  final IncidentListDatum incidentListDatum;

  const IncidentInjuredPersonTab(
      {Key? key,
      required this.incidentDetailsModel,
      required this.initialIndex,
      required this.incidentListDatum})
      : super(key: key);

  @override
  State<IncidentInjuredPersonTab> createState() =>
      _IncidentInjuredPersonTabState();
}

class _IncidentInjuredPersonTabState extends State<IncidentInjuredPersonTab> {
  bool isList = true;
  Map injuredPersonDetailMap = {};

  @override
  void initState() {
    isList = true;
    injuredPersonDetailMap = {};
    injuredPersonDetailMap['incidentId'] = widget.incidentListDatum.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation:
            (isList) ? FloatingActionButtonLocation.centerFloat : null,
        floatingActionButton: Visibility(
          visible: isList,
          child: FloatingActionButton.extended(
              label: Row(children: [
                const Icon(Icons.add),
                const SizedBox(width: tiniestSpacing),
                Text(DatabaseUtil.getText('addInjuredPersonPageHeading'))
              ]),
              onPressed: () {
                setState(() {
                  isList = false;
                });
                context.read<InjuryDetailsBloc>().add(const InjuryMaster());
              }),
        ),
        body: Visibility(
            visible: isList,
            replacement: BlocConsumer<InjuryDetailsBloc, InjuryDetailsStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingInjuryMaster ||
                    currentState is InjuryMasterFetched,
                listener: (context, state) {
                  if (state is SavingInjuryPerson) {
                    ProgressBar.show(context);
                  }
                  if (state is SavedInjuredPerson) {
                    ProgressBar.dismiss(context);
                    context.read<IncidentDetailsBloc>().add(
                        FetchIncidentDetailsEvent(
                            incidentId: widget.incidentListDatum.id,
                            role: context
                                .read<IncidentFetchAndChangeRoleBloc>()
                                .roleId,
                            initialIndex: widget.initialIndex));
                  }
                  if (state is ErrorSavingInjuredPerson) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.message, '');
                  }
                },
                builder: (context, state) {
                  if (state is FetchingInjuryMaster) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is InjuryMasterFetched) {
                    return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
                          InjuryScreenBody(
                              injuryNatureList:
                                  state.incidentInjuryMasterModel.data[0],
                              injuredPersonDetails: injuredPersonDetailMap),
                          const SizedBox(height: xxxSmallestSpacing),
                          Row(children: [
                            Expanded(
                                child: PrimaryButton(
                                    onPressed: () {
                                      setState(() {
                                        isList = true;
                                      });
                                    },
                                    textValue: DatabaseUtil.getText('Cancel'))),
                            const SizedBox(width: smallerSpacing),
                            Expanded(
                                child: PrimaryButton(
                                    onPressed: () {
                                      context.read<InjuryDetailsBloc>().add(
                                          SaveInjuredPerson(
                                              injuredPersonDetailMap));
                                    },
                                    textValue:
                                        DatabaseUtil.getText('buttonSave')))
                          ]),
                          const SizedBox(height: tiniestSpacing)
                        ]));
                  } else {
                    return const SizedBox();
                  }
                }),
            child: InjuredPersonList(
                incidentDetailsModel: widget.incidentDetailsModel)));
  }
}
