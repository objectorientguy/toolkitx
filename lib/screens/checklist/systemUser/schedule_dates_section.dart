import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/checklist/systemUser/system_user_cheklist_by_dates_model.dart';
import '../../../widgets/custom_card.dart';

class ScheduleDatesSection extends StatelessWidget {
  final GetChecklistDetailsData getChecklistDetailsData;
  final ChecklistScheduledByDatesModel getChecklistDetailsModel;

  const ScheduleDatesSection(
      {Key? key,
      required this.getChecklistDetailsData,
      required this.getChecklistDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: ListTile(
            title: Text(getChecklistDetailsData.dates,
                style: Theme.of(context).textTheme.xSmall),
            subtitle: Text(
                '${getChecklistDetailsData.responsecount} response out of ${getChecklistDetailsData.totalworkforcecount}',
                style: Theme.of(context)
                    .textTheme
                    .xxSmall
                    .copyWith(color: AppColor.grey)),
            onTap: () {
              context.read<ChecklistBloc>().add(CheckResponse(
                  scheduleId: getChecklistDetailsData.id,
                  getChecklistDetailsData: getChecklistDetailsData));
            }));
  }
}
