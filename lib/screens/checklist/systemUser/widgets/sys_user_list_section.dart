import 'dart:developer';
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
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../widgets/custom_tag_container.dart';

class SysUserListSection extends StatefulWidget {
  final int page;

  const SysUserListSection({Key? key, required this.page}) : super(key: key);

  @override
  State<SysUserListSection> createState() => _SysUserListSectionState();
}

class _SysUserListSectionState extends State<SysUserListSection> {
  var controller = ScrollController(keepScrollOffset: true);
  static List checkListData = [];
  static bool? noMoreData;
  static bool? waitForData;
  static int pageNo = 1;

  @override
  void initState() {
    pageNo = widget.page;
    pageNo = 1;
    noMoreData = false;
    checkListData.clear();
    log("pageNo=====>$pageNo");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BlocConsumer<SysUserCheckListBloc, SysUserCheckListStates>(
        buildWhen: (previousState, currentState) =>
            (currentState is CheckListFetched && noMoreData != true ||
                currentState is FetchingCheckList && checkListData.isEmpty),
        builder: (context, state) {
          if (state is CheckListFetched) {
            if (state.getChecklistModel.data!.isNotEmpty) {
              for (var item in state.getChecklistModel.data!) {
                checkListData.add(item);
                log("list=====>$checkListData");
              }
              waitForData = false;
              log("waitForData=====>$waitForData");
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      controller: controller
                        ..addListener(() {
                          if (noMoreData != true && waitForData == false) {
                            if (controller.position.extentAfter < 500) {
                              pageNo++;
                              context
                                  .read<SysUserCheckListBloc>()
                                  .add(FetchCheckList(page: pageNo));
                              waitForData = true;
                            }
                          }
                        }),
                      shrinkWrap: true,
                      itemCount: checkListData.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(tinier),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: xxTinierSpacing),
                                  child: Text(checkListData[index].name,
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
                                          '${checkListData[index].categoryname} -- ${checkListData[index].subcategoryname}',
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
                                              visible: checkListData[index]
                                                      .responsecount !=
                                                  0,
                                              child: const CustomTagContainer(
                                                  color: AppColor.lightGreen,
                                                  textValue: StringConstants
                                                      .kResponded),
                                            ),
                                            const SizedBox(width: tiniest),
                                            Visibility(
                                                visible: checkListData[index]
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
                                      arguments: checkListData[index].id);
                                }));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: xxTinySpacing);
                      }));
            } else {
              if (state.getChecklistModel.status == 204) {
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
              } else {
                return const SizedBox();
              }
            }
          } else if (state is FetchingCheckList) {
            return const CircularProgressIndicator();
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {
          if (state is CheckListFetched) {
            if (state.getChecklistModel.status == 204) {
              log("listenerr======>");
              noMoreData = true;
              log("noMoreData======>$noMoreData");
              showCustomSnackBar(context, 'All Data Loaded', '');
            }
          }
        },
      )
    ]));
  }
}
