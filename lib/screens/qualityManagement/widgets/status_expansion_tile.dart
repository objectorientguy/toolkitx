import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/quality_management_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/quality_management_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class QualityManagementStatusExpansionTile extends StatelessWidget {
  final List selectedStatus;
  final List filterStatus;

  const QualityManagementStatusExpansionTile(
      {Key? key, required this.selectedStatus, required this.filterStatus})
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
                selectedStatus.isEmpty
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
                  itemCount: filterStatus.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                        checkColor: AppColor.white,
                        activeColor: AppColor.deepBlue,
                        contentPadding: EdgeInsets.zero,
                        value: selectedStatus.contains(filterStatus[index]),
                        title: Text(filterStatus[index]),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) {
                          context.read<QualityManagementBloc>().add(
                              FilterStatusDropDown(
                                  selectedStatus: selectedStatus,
                                  itemIndex: index));
                          log("checkedd=======>$selectedStatus");
                        });
                  })
            ]));
  }
}
