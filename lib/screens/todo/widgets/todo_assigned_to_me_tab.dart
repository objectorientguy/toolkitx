import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/todo/todoAssignToMe/todo_assign_to_me_bloc.dart';
import '../../../blocs/todo/todoAssignToMe/todo_assign_to_me_event.dart';
import '../../../blocs/todo/todoAssignToMe/todo_assign_to_me_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/status_tag.dart';

class TodoAssignedToMeTab extends StatelessWidget {
  const TodoAssignedToMeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoAssignToMeListBloc, TodoAssignToMeListStates>(
        builder: (context, state) {
      if (state is FetchTodoAssignToMeList) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TodoAssignToMeListFetched) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                state.fetchToDoAssignToMeListModel.assignToMeListDatum.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: Padding(
                      padding: const EdgeInsets.only(top: tinierSpacing),
                      child: ListTile(
                          onTap: () {},
                          title: Text(
                              state.fetchToDoAssignToMeListModel
                                  .assignToMeListDatum[index].todoname,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black)),
                          subtitle: Padding(
                              padding:
                                  const EdgeInsets.only(top: tinierSpacing),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        state
                                            .fetchToDoAssignToMeListModel
                                            .assignToMeListDatum[index]
                                            .description,
                                        maxLines: 3),
                                    const SizedBox(height: tinierSpacing),
                                    Text(
                                        state
                                            .fetchToDoAssignToMeListModel
                                            .assignToMeListDatum[index]
                                            .category,
                                        maxLines: 3),
                                    const SizedBox(height: tinierSpacing),
                                    Row(children: [
                                      Image.asset('assets/icons/calendar.png',
                                          height: kImageHeight,
                                          width: kImageWidth),
                                      const SizedBox(width: tiniestSpacing),
                                      Text(state.fetchToDoAssignToMeListModel
                                          .assignToMeListDatum[index].duedate)
                                    ]),
                                    const SizedBox(height: tinierSpacing),
                                    StatusTag(tags: [
                                      StatusTagModel(
                                          title: (state
                                                      .fetchToDoAssignToMeListModel
                                                      .assignToMeListDatum[
                                                          index]
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
      } else {
        return const SizedBox();
      }
    });
  }
}
