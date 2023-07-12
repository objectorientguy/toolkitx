import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/icon_and_text_row.dart';
import '../../../widgets/status_tag.dart';

class TodoAssignedByMeBody extends StatelessWidget {
  final List<AssignByMeListDatum> assignedByMeListDatum;

  const TodoAssignedByMeBody({Key? key, required this.assignedByMeListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: assignedByMeListDatum.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: tinierSpacing),
                  child: ListTile(
                      onTap: () {},
                      title: Text(assignedByMeListDatum[index].todoname,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: tinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(assignedByMeListDatum[index].description,
                                    maxLines: 3),
                                const SizedBox(height: tinierSpacing),
                                Text(assignedByMeListDatum[index].category),
                                const SizedBox(height: tinierSpacing),
                                Row(children: [
                                  Image.asset('assets/icons/calendar.png',
                                      height: kImageHeight, width: kImageWidth),
                                  const SizedBox(width: tiniestSpacing),
                                  Text(assignedByMeListDatum[index].duedate)
                                ]),
                                const SizedBox(height: tinierSpacing),
                                IconAndTextRow(
                                    title:
                                        assignedByMeListDatum[index].createdfor,
                                    icon: 'human_avatar_three'),
                                const SizedBox(height: tinierSpacing),
                                StatusTag(tags: [
                                  StatusTagModel(
                                      title: (assignedByMeListDatum[index]
                                                  .istododue ==
                                              1)
                                          ? DatabaseUtil.getText('Overdue')
                                          : '',
                                      bgColor: AppColor.errorRed),
                                ])
                              ])))));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: tinierSpacing);
        });
  }
}
