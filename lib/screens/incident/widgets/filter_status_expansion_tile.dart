import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incident_bloc.dart';
import 'package:toolkit/blocs/incident/incident_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class FilterStatusExpansionTile extends StatelessWidget {
  final List selectedStatus;
  final List status;

  const FilterStatusExpansionTile(
      {Key? key, required this.selectedStatus, required this.status})
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
                (selectedStatus.isEmpty)
                    ? StringConstants.kSelectStatus
                    : selectedStatus
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', ''),
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: status.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                        checkColor: AppColor.white,
                        activeColor: AppColor.deepBlue,
                        contentPadding: EdgeInsets.zero,
                        value: selectedStatus.contains(status[index]),
                        title: Text(status[index]),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) {
                          context.read<IncidentBloc>().add(FilterStatusChanged(
                              selectedStatus: selectedStatus,
                              listIndex: index));
                        });
                  })
            ]));
  }
}
