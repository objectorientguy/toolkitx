import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/widgets/custom_visibility_tags_container.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/checklist/systemUser/checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/checklist/systemUser/list_model.dart';
import '../../onboarding/widgets/custom_card.dart';

class SystemUserListLayout extends StatelessWidget {
  final GetChecklistModel getChecklistModel;

  const SystemUserListLayout({Key? key, required this.getChecklistModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: getChecklistModel.data!.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(midTinySpacing),
                      title: Padding(
                        padding:
                            const EdgeInsets.only(bottom: midTiniestSpacing),
                        child: Text(getChecklistModel.data![index].name,
                            style: Theme.of(context)
                                .textTheme
                                .small
                                .copyWith(color: AppColor.black)),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${getChecklistModel.data![index].categoryname} -- ${getChecklistModel.data![index].subcategoryname.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.grey)),
                            const SizedBox(height: tinySpacing),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomVisibilityTagContainer(
                                      visible: getChecklistModel
                                              .data![index].responsecount !=
                                          0,
                                      color: AppColor.lightGreen,
                                      textValue: StringConstants.kResponded),
                                  const SizedBox(width: tiniestSpacing),
                                  Visibility(
                                      visible: getChecklistModel.data![index]
                                              .approvalpendingcount !=
                                          0,
                                      child: const Icon(
                                          Icons.question_mark_outlined,
                                          color: AppColor.errorRed,
                                          size: kIconSize))
                                ])
                          ]),
                      onTap: () {
                        context.read<ChecklistBloc>().add(
                            FetchChecklistScheduleDates(
                                checklistId:
                                    getChecklistModel.data![index].id));
                      }));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: tinySpacing);
            }));
  }
}
