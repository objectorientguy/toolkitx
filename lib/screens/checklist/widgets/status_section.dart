import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/systemUser/checklist/status_model.dart';

import '../../../blocs/systemUser/checklist/checklist_bloc.dart';
import '../../../blocs/systemUser/checklist/checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../onboarding/widgets/custom_card.dart';

class SystemUserStatusSection extends StatelessWidget {
  final GetChecklistStatusModel getChecklistStatusModel;

  const SystemUserStatusSection(
      {Key? key, required this.getChecklistStatusModel})
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
                    contentPadding: const EdgeInsets.all(midTinySpacing),
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: tiniestSpacing),
                        child: Text(getChecklistStatusModel.data![index].name,
                            style: Theme.of(context)
                                .textTheme
                                .small
                                .copyWith(color: AppColor.black))),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${getChecklistStatusModel.data![index].jobtitle} ${getChecklistStatusModel.data![index].company}',
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.grey)),
                          const SizedBox(height: tiniestSpacing),
                          Text(
                              'Response Date: ${getChecklistStatusModel.data![index].responsedate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.grey)),
                          const SizedBox(height: tiniestSpacing),
                          Text('Approved',
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.grey))
                        ]),
                    trailing: Visibility(
                      visible:
                          getChecklistStatusModel.data![index].responseid != "",
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: kIconSize,
                          onPressed: () {
                            context.read<ChecklistBloc>().add(FetchPdf(
                                responseId: getChecklistStatusModel
                                    .data![index].responseid));
                          },
                          icon: const Icon(Icons.attach_file_outlined)),
                    )));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinySpacing);
          }),
    );
  }
}
