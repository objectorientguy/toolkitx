import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';

import '../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../blocs/report_new_incident/report_new_incident_events.dart';

class InjuryMultiSelect extends StatelessWidget {
  final List injuryNatureSelected;

  final List selectedInjuredArea;
  final List injuryArea;

  const InjuryMultiSelect(
      {Key? key,
      required this.injuryNatureSelected,
      required this.selectedInjuredArea,
      required this.injuryArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 10,
            childAspectRatio: 4 / 2),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 37,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            child: Row(
              children: [
                Text(injuryArea[index]),
                Checkbox(
                    activeColor: AppColor.deepBlue,
                    value: selectedInjuredArea.contains(injuryArea[index]),
                    onChanged: (isChecked) {
                      context.read<ReportIncidentBloc>().add(
                          SelectInjuryMultiSelect(
                              selectedInjuryNature: injuryNatureSelected,
                              natureIndex: null,
                              selectedInjuredArea: selectedInjuredArea,
                              areaIndex: index));
                    }),
              ],
            ),
          );
        });
  }
}
