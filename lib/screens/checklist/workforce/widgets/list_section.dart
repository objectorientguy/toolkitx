import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/checklist/workforce/list_model.dart';
import '../../../../blocs/checklist/workforce/workforce_checklist_bloc.dart';
import '../../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../onboarding/widgets/custom_card.dart';
import '../../widgets/custom_visibility_tags_container.dart';

class ListSection extends StatelessWidget {
  final WorkforceGetCheckListModel workforceGetCheckListModel;

  const ListSection({Key? key, required this.workforceGetCheckListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: workforceGetCheckListModel.data!.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: ListTile(
                  contentPadding: const EdgeInsets.all(midTinySpacing),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: midTiniestSpacing),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(workforceGetCheckListModel.data![index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(color: AppColor.black)),
                            const SizedBox(width: midTiniestSpacing),
                            Visibility(
                                visible: workforceGetCheckListModel
                                        .data![index].isdraft ==
                                    1,
                                child: Text(StringConstants.kDraft,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(color: AppColor.errorRed)))
                          ])),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Assign Date: ${workforceGetCheckListModel.data![index].submitdate}  -- Due on: ${workforceGetCheckListModel.data![index].overduedate}',
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.grey)),
                        const SizedBox(height: midTiniestSpacing),
                        Text(
                            '${workforceGetCheckListModel.data![index].categoryname} -- ${workforceGetCheckListModel.data![index].subcategoryname}',
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.grey)),
                        const SizedBox(height: midTiniestSpacing),
                        Visibility(
                          visible: workforceGetCheckListModel
                                  .data![index].isrejected !=
                              '0',
                          child: const CustomTagContainer(
                              color: AppColor.errorRed,
                              textValue: StringConstants.kNotAccepted),
                        ),
                        Visibility(
                          visible: workforceGetCheckListModel
                                  .data![index].isoverdue !=
                              '0',
                          child: const CustomTagContainer(
                              color: AppColor.yellow,
                              textValue: StringConstants.kOverdue),
                        )
                      ]),
                  onTap: () {
                    Map checklistDataMap = {
                      "scheduleId": workforceGetCheckListModel
                          .data![index].scheduleid
                          .toString(),
                      "userId": 'W2mt1FgZTZTQWTIvm4wU1w==',
                      "checklistId": workforceGetCheckListModel.data![index].id,
                      "isDraft":
                          workforceGetCheckListModel.data![index].isdraft,
                      "isRejected":
                          workforceGetCheckListModel.data![index].isrejected
                    };
                    context
                        .read<WorkforceChecklistBloc>()
                        .add(FetchQuestions(checklistData: checklistDataMap));
                  }));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: tinySpacing);
        });
  }
}
