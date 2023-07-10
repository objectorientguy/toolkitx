// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
// import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
// import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
// import '../../../../configs/app_spacing.dart';
// import '../../../../utils/constants/string_constants.dart';
// import '../../../../utils/database_utils.dart';
// import '../../../../widgets/custom_snackbar.dart';
// import '../../../../widgets/generic_no_records_text.dart';
// import '../sys_user_checklist_list_screen.dart';
// import 'sys_user_list_card.dart';
//
// class SysUserListSection extends StatefulWidget {
//   static List checkListData = [];
//   static bool noMoreData = false;
//
//   const SysUserListSection({Key? key}) : super(key: key);
//
//   @override
//   State<SysUserListSection> createState() => _SysUserListSectionState();
// }
//
// class _SysUserListSectionState extends State<SysUserListSection> {
//   var controller = ScrollController(keepScrollOffset: true);
//   static bool waitForData = false;
//
//   @override
//   void initState() {
//     SystemUserCheckListScreen.page = 1;
//     SysUserListSection.noMoreData = false;
//     SysUserListSection.checkListData.clear();
//     log("widget.checkListData====>${SysUserListSection.checkListData}");
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SysUserCheckListBloc, SysUserCheckListStates>(
//         buildWhen: (previousState, currentState) =>
//             ((currentState is CheckListFetched &&
//                     SysUserListSection.noMoreData != true) ||
//                 (currentState is FetchingCheckList &&
//                     SystemUserCheckListScreen.page == 1)),
//         listener: (context, state) {
//           if (state is FetchingCheckList) {
//             log("FetchingCheckList====>${SysUserListSection.checkListData}");
//           }
//           if (state is CheckListFetched) {
//             if (state.getChecklistModel.status == 204 &&
//                 SysUserListSection.checkListData.isNotEmpty) {
//               SysUserListSection.noMoreData = true;
//               showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
//             }
//           }
//         },
//         builder: (context, state) {
//           if (state is CheckListFetched) {
//             if (state.getChecklistModel.data!.isNotEmpty) {
//               if (SystemUserCheckListScreen.page == 1) {
//                 SysUserListSection.checkListData =
//                     state.getChecklistModel.data!;
//               } else {
//                 for (var item in state.getChecklistModel.data!) {
//                   SysUserListSection.checkListData.add(item);
//                 }
//               }
//               waitForData = false;
//               return Expanded(
//                   child: ListView.separated(
//                       physics: const BouncingScrollPhysics(),
//                       controller: controller
//                         ..addListener(() {
//                           if (SysUserListSection.noMoreData != true &&
//                               waitForData == false) {
//                             if (controller.position.extentAfter < 500) {
//                               SystemUserCheckListScreen.page++;
//                               context.read<SysUserCheckListBloc>().add(
//                                   FetchCheckList(
//                                       isFromHome: false,
//                                       page: SystemUserCheckListScreen.page));
//                               waitForData = true;
//                             }
//                           }
//                         }),
//                       shrinkWrap: true,
//                       itemCount: SysUserListSection.checkListData.length,
//                       itemBuilder: (context, index) {
//                         return SystemUserListCard(
//                             checkListDatum:
//                                 SysUserListSection.checkListData[index]);
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return const SizedBox(height: xxTinySpacing);
//                       }));
//             } else {
//               if (state.getChecklistModel.status == 204) {
//                 if (state.filterData == '{}') {
//                   return NoRecordsText(
//                       text: DatabaseUtil.getText('no_records_found'));
//                 } else {
//                   return const NoRecordsText(
//                       text: StringConstants.kNoRecordsFilter);
//                 }
//               } else {
//                 return const SizedBox();
//               }
//             }
//           } else if (state is FetchingCheckList) {
//             return Center(
//               child: Padding(
//                   padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 3.5),
//                   child: const CircularProgressIndicator()),
//             );
//           } else {
//             return const SizedBox();
//           }
//         });
//   }
// }
