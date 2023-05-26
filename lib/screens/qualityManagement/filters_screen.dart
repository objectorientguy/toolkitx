import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/quality_management_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/qualityManagement/quality_management_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';
import 'widgets/status_expansion_tile.dart';

class QualityManagementFiltersScreen extends StatelessWidget {
  static const routeName = 'QualityManagementFiltersScreen';

  const QualityManagementFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kFilter),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: BlocBuilder<QualityManagementBloc, QualityManagementSates>(
                builder: (context, state) {
              if (state is FilterStatusDropDownLoaded) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(StringConstants.kDateRange,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: tinySpacing),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DatePickerTextField(
                                hintText: StringConstants.kSelectDate,
                              ),
                            ),
                            const SizedBox(width: midTiniestSpacing),
                            const Text(StringConstants.kBis),
                            const SizedBox(width: midTiniestSpacing),
                            Expanded(
                                child: DatePickerTextField(
                                    hintText: StringConstants.kSelectDate))
                          ]),
                      const SizedBox(height: tinySpacing),
                      Text(StringConstants.kStatus,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: tinySpacing),
                      QualityManagementStatusExpansionTile(
                          selectedStatus: state.selectedStatus,
                          filterStatus: state.filterStatus),
                      const SizedBox(height: mediumSpacing),
                      PrimaryButton(
                          onPressed: () {}, textValue: StringConstants.kApply)
                    ]);
              } else {
                return const SizedBox();
              }
            })));
  }
}
