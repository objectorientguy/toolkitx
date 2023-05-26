import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/systemUser/checklist/details_model.dart';

import '../../../blocs/systemUser/checklist/checklist_bloc.dart';
import '../../../blocs/systemUser/checklist/checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../onboarding/widgets/custom_card.dart';

class DetailsSection extends StatelessWidget {
  final GetChecklistDetailsData getChecklistDetailsData;
  final GetChecklistDetailsModel getChecklistDetailsModel;

  const DetailsSection(
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
              context.read<ChecklistBloc>().add(NavigateToStatusScreen(
                  scheduleId: getChecklistDetailsData.id,
                  getChecklistDetailsData: getChecklistDetailsData,
                  getChecklistDetailsModel: getChecklistDetailsModel));
            }));
  }
}
