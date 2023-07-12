import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/status_tag.dart';
import '../todo_details_and_document_details_screen.dart';

class TodoAssignedToMeBody extends StatelessWidget {
  final List<AssignedToMeListDatum> assignToMeListDatum;
  final Map todoMap;

  const TodoAssignedToMeBody(
      {Key? key, required this.assignToMeListDatum, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (assignToMeListDatum.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoToDoAssignedTo,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: assignToMeListDatum.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                      child: Padding(
                          padding: const EdgeInsets.only(top: tinierSpacing),
                          child: ListTile(
                              onTap: () {
                                todoMap['todoId'] =
                                    assignToMeListDatum[index].id;
                                todoMap['todoName'] =
                                    assignToMeListDatum[index].todoname;
                                Navigator.pushNamed(
                                    context,
                                    ToDoDetailsAndDocumentDetailsScreen
                                        .routeName,
                                    arguments: todoMap);
                              },
                              title: Text(assignToMeListDatum[index].todoname,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.black)),
                              subtitle: Padding(
                                  padding:
                                      const EdgeInsets.only(top: tinierSpacing),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            assignToMeListDatum[index]
                                                .description,
                                            maxLines: 3),
                                        const SizedBox(height: tinierSpacing),
                                        Text(
                                            assignToMeListDatum[index].category,
                                            maxLines: 3),
                                        const SizedBox(height: tinierSpacing),
                                        Row(children: [
                                          Image.asset(
                                              'assets/icons/calendar.png',
                                              height: kImageHeight,
                                              width: kImageWidth),
                                          const SizedBox(width: tiniestSpacing),
                                          Text(assignToMeListDatum[index]
                                              .duedate)
                                        ]),
                                        const SizedBox(height: tinierSpacing),
                                        StatusTag(tags: [
                                          StatusTagModel(
                                              title: (assignToMeListDatum[index]
                                                          .istododue ==
                                                      1)
                                                  ? DatabaseUtil.getText(
                                                      'Overdue')
                                                  : '',
                                              bgColor: AppColor.errorRed),
                                        ])
                                      ])))));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tinierSpacing);
                }),
          );
  }
}
