import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_schedule_dates_screen.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/custom_card.dart';
import '../../widgets/custom_tag_container.dart';

class SysUserListSection extends StatelessWidget {
  const SysUserListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BlocBuilder<SysUserCheckListBloc, SysUserCheckListStates>(
          buildWhen: (previousState, currentState) =>
              (currentState is CheckListFetched ||
                  currentState is FetchingCheckList),
          builder: (context, state) {
            if (state is CheckListFetched) {
              if (state.getChecklistModel.data!.isNotEmpty) {
                return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.getChecklistModel.data!.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: ListTile(
                                  contentPadding: const EdgeInsets.all(tinier),
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: xxTinierSpacing),
                                    child: Text(
                                        state.getChecklistModel.data![index]
                                            .name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(color: AppColor.black)),
                                  ),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${state.getChecklistModel.data![index].categoryname} -- ${state.getChecklistModel.data![index].subcategoryname}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.grey)),
                                        const SizedBox(height: xxTinySpacing),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: state
                                                        .getChecklistModel
                                                        .data![index]
                                                        .responsecount !=
                                                    0,
                                                child: const CustomTagContainer(
                                                    color: AppColor.lightGreen,
                                                    textValue: StringConstants
                                                        .kResponded),
                                              ),
                                              const SizedBox(width: tiniest),
                                              Visibility(
                                                  visible: state
                                                          .getChecklistModel
                                                          .data![index]
                                                          .approvalpendingcount !=
                                                      0,
                                                  child: const Icon(
                                                      Icons
                                                          .question_mark_outlined,
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
              } else {
                if (state.filterData.isEmpty) {
                  return Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.5),
                          child:
                              Text(DatabaseUtil.getText('no_records_found'))));
                } else {
                  return Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.5),
                          child: const Text(StringConstants.kNoRecordsFilter)));
                }
              }
            } else if (state is FetchingCheckList) {
              return const CircularProgressIndicator();
            } else {
              return const SizedBox();
            }
          })
    ]));
  }
}
