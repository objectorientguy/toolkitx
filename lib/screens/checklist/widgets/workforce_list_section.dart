import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/checklist/systemUser/system_user_workfoce_list_model.dart';
import '../../onboarding/widgets/custom_card.dart';

class SystemUserWorkForceListSection extends StatelessWidget {
  final ChecklistWorkforceListModel getChecklistStatusModel;
  final List selectedStatusList;

  const SystemUserWorkForceListSection(
      {Key? key,
      required this.getChecklistStatusModel,
      required this.selectedStatusList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: getChecklistStatusModel.data!.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(tinier),
                      title: Padding(
                          padding: const EdgeInsets.only(bottom: tiniest),
                          child: Text(getChecklistStatusModel.data![index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .small
                                  .copyWith(color: AppColor.black))),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${getChecklistStatusModel.data![index].jobtitle} -- ${getChecklistStatusModel.data![index].company}',
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.grey)),
                            const SizedBox(height: tiniest),
                            Text(
                                'Response Date: ${getChecklistStatusModel.data![index].responsedate}',
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.grey)),
                            const SizedBox(height: tiniest),
                            Visibility(
                              visible: getChecklistStatusModel
                                      .data![index].approvalstatus ==
                                  1,
                              child: Text(StringConstants.kApproved,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(color: AppColor.grey)),
                            ),
                            const SizedBox(height: tiniest),
                            Visibility(
                                visible: getChecklistStatusModel
                                        .data![index].responseid !=
                                    "",
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    iconSize: kIconSize,
                                    onPressed: () {
                                      context.read<ChecklistBloc>().add(
                                          FetchPdf(
                                              responseId:
                                                  getChecklistStatusModel
                                                      .data![index]
                                                      .responseid));
                                    },
                                    icon:
                                        const Icon(Icons.attach_file_outlined)))
                          ]),
                      trailing: Visibility(
                          visible: getChecklistStatusModel
                                  .data![index].responseid.isNotEmpty &&
                              getChecklistStatusModel
                                      .data![index].isdeptapprove ==
                                  "1",
                          child: Checkbox(
                              value: selectedStatusList.contains(
                                  getChecklistStatusModel
                                      .data![index].responseid),
                              onChanged: (value) {
                                context.read<ChecklistBloc>().add(
                                    StatusCheckBoxCheck(
                                        responseId:
                                            getChecklistStatusModel
                                                .data![index].responseid,
                                        getChecklistStatusModel:
                                            getChecklistStatusModel,
                                        selectedResponseIds:
                                            selectedStatusList));
                              }))));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinySpacing);
            }));
  }
}
