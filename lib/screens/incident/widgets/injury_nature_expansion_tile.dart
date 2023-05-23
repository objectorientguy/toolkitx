import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../blocs/report_new_incident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class InjuryNatureExpansionTile extends StatelessWidget {
  final List injuryNatureSelected;
  final List selectedInjuredArea;
  final List injuryNature;
  const InjuryNatureExpansionTile(
      {Key? key,
      required this.injuryNatureSelected,
      required this.selectedInjuredArea,
      required this.injuryNature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: expansionTileMargin, right: expansionTileMargin),
            collapsedBackgroundColor: AppColor.white,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            title: Text(
                (injuryNatureSelected.isEmpty)
                    ? StringConstants.kSelect
                    : injuryNatureSelected
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', ''),
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: injuryNature.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                        checkColor: AppColor.white,
                        activeColor: AppColor.deepBlue,
                        contentPadding: EdgeInsets.zero,
                        value:
                            injuryNatureSelected.contains(injuryNature[index]),
                        title: Text(injuryNature[index]),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) {
                          context.read<ReportIncidentBloc>().add(
                              SelectInjuryMultiSelect(
                                  selectedInjuryNature: injuryNatureSelected,
                                  natureIndex: index,
                                  selectedInjuredArea: selectedInjuredArea,
                                  areaIndex: null));
                        });
                  })
            ]));
  }
}
