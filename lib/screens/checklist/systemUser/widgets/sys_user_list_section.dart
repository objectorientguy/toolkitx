import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_schedule_dates_screen.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/error_section.dart';
import '../../widgets/custom_tag_container.dart';

class SysUserListSection extends StatelessWidget {
  final List<GetChecklistData> checklistData = [];
  final ScrollController scrollController = ScrollController();

  SysUserListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BlocConsumer<SysUserCheckListBloc, SysUserCheckListStates>(
          listenWhen: (previousState, currentState) =>
              currentState is FetchingCheckList && checklistData.isNotEmpty ||
              currentState is CheckListFetched ||
              currentState is CheckListError && checklistData.isNotEmpty,
          buildWhen: (previousState, currentState) =>
              currentState is FetchingCheckList ||
              currentState is CheckListFetched ||
              currentState is CheckListError && checklistData.isEmpty,
          listener: (context, state) {
            if (state is CheckListError &&
                checklistData.isNotEmpty &&
                context.read<SysUserCheckListBloc>().filterData == '{}') {
              showCustomSnackBar(context, StringConstants.kNoMoreData, '');
              context.read<SysUserCheckListBloc>().isFetching = false;
            }
          },
          builder: (context, state) {
            if (state is CheckListInitial || state is FetchingCheckList) {
              return const CircularProgressIndicator();
            } else if (state is CheckListFetched) {
              checklistData.addAll(state.getChecklistModel.data!);
              context.read<SysUserCheckListBloc>().isFetching = false;
            } else if (state is CheckListError && checklistData.isEmpty) {
              return GenericReloadButton(
                  onPressed: () {
                    context.read<SysUserCheckListBloc>().add(FetchCheckList());
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox();
            }
            return Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: checklistData.length,
                    controller: scrollController
                      ..addListener(() {
                        if (scrollController.offset ==
                                scrollController.position.maxScrollExtent &&
                            !context.read<SysUserCheckListBloc>().isFetching) {
                          context.read<SysUserCheckListBloc>()
                            ..isFetching = true
                            ..add(FetchCheckList());
                        }
                      }),
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: ListTile(
                              contentPadding: const EdgeInsets.all(tinier),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: xxTinierSpacing),
                                child: Text(checklistData[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(color: AppColor.black)),
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${checklistData[index].categoryname} -- ${checklistData[index].subcategoryname.toString()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(color: AppColor.grey)),
                                    const SizedBox(height: xxTinySpacing),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: checklistData[index]
                                                    .responsecount !=
                                                0,
                                            child: const CustomTagContainer(
                                                color: AppColor.lightGreen,
                                                textValue:
                                                    StringConstants.kResponded),
                                          ),
                                          const SizedBox(width: tiniest),
                                          Visibility(
                                              visible: checklistData[index]
                                                      .approvalpendingcount !=
                                                  0,
                                              child: const Icon(
                                                  Icons.question_mark_outlined,
                                                  color: AppColor.errorRed,
                                                  size: kIconSize))
                                        ])
                                  ]),
                              onTap: () {
                                Navigator.pushNamed(context,
                                    SystemUserScheduleDatesScreen.routeName,
                                    arguments: state
                                        .getChecklistModel.data![index].id);
                              }));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: xxTinySpacing);
                    }));
          })
    ]));
  }
}
