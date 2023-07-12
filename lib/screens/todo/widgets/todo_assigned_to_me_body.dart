import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/status_tag.dart';

class TodoAssignedToMeBody extends StatelessWidget {
  final List<AssignedToMeListDatum> assignToMeListDatum;

  const TodoAssignedToMeBody({Key? key, required this.assignToMeListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: assignToMeListDatum.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: tinierSpacing),
                  child: ListTile(
                      onTap: () {},
                      title: Text(assignToMeListDatum[index].todoname,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: tinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(assignToMeListDatum[index].description,
                                    maxLines: 3),
                                const SizedBox(height: tinierSpacing),
                                Text(assignToMeListDatum[index].category,
                                    maxLines: 3),
                                const SizedBox(height: tinierSpacing),
                                Row(children: [
                                  Image.asset('assets/icons/calendar.png',
                                      height: kImageHeight, width: kImageWidth),
                                  const SizedBox(width: tiniestSpacing),
                                  Text(assignToMeListDatum[index].duedate)
                                ]),
                                const SizedBox(height: tinierSpacing),
                                StatusTag(tags: [
                                  StatusTagModel(
                                      title: (assignToMeListDatum[index]
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
