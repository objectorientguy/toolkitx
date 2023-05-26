import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/systemUser/checklist/checklist_bloc.dart';
import '../../../blocs/systemUser/checklist/checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../onboarding/widgets/custom_card.dart';

class ChecklistListSection extends StatelessWidget {
  final GetChecklistModel getChecklistModel;

  const ChecklistListSection({Key? key, required this.getChecklistModel})
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
                            Row(children: [
                              Text(
                                  '${getChecklistModel.data![index].categoryname}  --',
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(color: AppColor.grey)),
                              const SizedBox(width: tiniestSpacing),
                              Text(
                                  getChecklistModel.data![index].subcategoryname
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(color: AppColor.grey))
                            ]),
                            const SizedBox(height: tinySpacing),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: getChecklistModel
                                            .data![index].responsecount !=
                                        0,
                                    child: Container(
                                        padding: const EdgeInsets.all(
                                            tiniestSpacing),
                                        decoration: BoxDecoration(
                                            color: AppColor.lightGreen,
                                            borderRadius: BorderRadius.circular(
                                                kCardRadius)),
                                        height: kTagsHeight,
                                        child: Text(StringConstants.kResponded,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.white))),
                                  ),
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
                        context.read<ChecklistBloc>().add(FetchChecklistDetails(
                            checklistId: getChecklistModel.data![index].id));
                      }));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: tinySpacing);
            }));
  }
}
