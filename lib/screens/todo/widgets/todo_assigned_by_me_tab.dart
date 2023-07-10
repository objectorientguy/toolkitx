import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/todo/todoAssignByMe/todo_assign_by_me_bloc.dart';
import '../../../blocs/todo/todoAssignByMe/todo_assign_by_me_event.dart';
import '../../../blocs/todo/todoAssignByMe/todo_assign_by_me_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/icon_and_text_row.dart';
import '../../../widgets/status_tag.dart';

class TodoAssignedByMeTab extends StatelessWidget {
  const TodoAssignedByMeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TodoAssignByMeListBloc>().add(FetchTodoAssignByMeList());
    return BlocBuilder<TodoAssignByMeListBloc, TodoAssignByMeListStates>(
        builder: (context, state) {
      if (state is FetchingTodoAssignByMeList) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TodoAssignByMeListFetched) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                state.fetchToDoAssignToByListModel.assignedByMeListDatum.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: Padding(
                      padding: const EdgeInsets.only(top: tinierSpacing),
                      child: ListTile(
                          onTap: () {},
                          title: Text(
                              state.fetchToDoAssignToByListModel
                                  .assignedByMeListDatum[index].todoname,
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
                                            .fetchToDoAssignToByListModel
                                            .assignedByMeListDatum[index]
                                            .description,
                                        maxLines: 3),
                                    const SizedBox(height: tinierSpacing),
                                    Text(state.fetchToDoAssignToByListModel
                                        .assignedByMeListDatum[index].category),
                                    const SizedBox(height: tinierSpacing),
                                    Row(children: [
                                      Image.asset('assets/icons/calendar.png',
                                          height: kImageHeight,
                                          width: kImageWidth),
                                      const SizedBox(width: tiniestSpacing),
                                      Text(state.fetchToDoAssignToByListModel
                                          .assignedByMeListDatum[index].duedate)
                                    ]),
                                    const SizedBox(height: tinierSpacing),
                                    IconAndTextRow(
                                        title: state
                                            .fetchToDoAssignToByListModel
                                            .assignedByMeListDatum[index]
                                            .createdfor,
                                        icon: 'human_avatar_three'),
                                    const SizedBox(height: tinierSpacing),
                                    StatusTag(tags: [
                                      StatusTagModel(
                                          title: (state
                                                      .fetchToDoAssignToByListModel
                                                      .assignedByMeListDatum[
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
