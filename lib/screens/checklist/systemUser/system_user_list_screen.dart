import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/system_user_checklist_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/change_role_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/filters_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/checklist/systemUser/system_user_list_model.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/error_section.dart';
import '../../../widgets/progress_bar.dart';
import '../widgets/custom_tags_container.dart';
import 'schedule_dates_screen.dart';

class SystemUserCheckListScreen extends StatelessWidget {
  static const routeName = 'SystemUserCheckListScreen';
  final List<GetChecklistData> checklistData = [];
  final ScrollController scrollController = ScrollController();

  SystemUserCheckListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChecklistBloc>().add(FetchChecklist());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChecklist),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              BlocListener<ChecklistBloc, ChecklistStates>(
                listener: (context, state) {
                  if (state is FetchingRoles) {
                    ProgressBar.show(context);
                  } else if (state is RolesFetched) {
                    ProgressBar.dismiss(context);
                    Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                  } else if (state is CategoryFetching) {
                    ProgressBar.show(context);
                  } else if (state is CategoryFetched) {
                    ProgressBar.dismiss(context);
                    Navigator.pushNamed(context, FiltersScreen.routeName);
                  }
                },
                child: CustomIconButtonRow(
                    primaryOnPress: () {
                      context.read<ChecklistBloc>().add(FetchCategory());
                    },
                    secondaryOnPress: () {
                      context.read<ChecklistBloc>().add(FetchRoles());
                    },
                    clearVisible: false,
                    isEnabled: true,
                    clearOnPress: () {}),
              ),
              const SizedBox(height: tiniest),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<ChecklistBloc, ChecklistStates>(
                        listenWhen: (previousState, currentState) =>
                            (currentState is ChecklistFetching &&
                                checklistData.isNotEmpty) ||
                            (currentState is ChecklistError &&
                                checklistData.isNotEmpty) ||
                            currentState is FetchingChecklistScheduleDates ||
                            currentState is ChecklistDatesScheduled,
                        buildWhen: (previousState, currentState) =>
                            currentState is ChecklistFetched ||
                            currentState is ChecklistError &&
                                checklistData.isEmpty,
                        listener: (context, state) {
                          if (state is FetchingChecklistScheduleDates) {
                            ProgressBar.show(context);
                          } else if (state is ChecklistDatesScheduled) {
                            ProgressBar.dismiss(context);
                            Navigator.pushNamed(context,
                                SystemUserScheduleDatesScreen.routeName);
                          } else if (state is ChecklistFetching) {
                            showCustomSnackBar(context, 'Loading data', '');
                          } else if (state is ChecklistError &&
                              checklistData.isNotEmpty) {
                            showCustomSnackBar(context, 'No more data!', '');
                            context.read<ChecklistBloc>().isFetching = false;
                          }
                        },
                        builder: (context, state) {
                          if (state is ChecklistInitial ||
                              state is ChecklistFetching &&
                                  checklistData.isEmpty) {
                            return const CircularProgressIndicator();
                          } else if (state is ChecklistFetched) {
                            checklistData.addAll(state.getChecklistModel.data!);
                            context.read<ChecklistBloc>().isFetching = false;
                          } else if (state is ChecklistError &&
                              checklistData.isEmpty) {
                            return GenericReloadButton(
                                onPressed: () {
                                  context
                                      .read<ChecklistBloc>()
                                      .add(FetchChecklist());
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
                                              scrollController
                                                  .position.maxScrollExtent &&
                                          !context
                                              .read<ChecklistBloc>()
                                              .isFetching) {
                                        context.read<ChecklistBloc>()
                                          ..isFetching = true
                                          ..add(FetchChecklist());
                                      }
                                    }),
                                  itemBuilder: (context, index) {
                                    return CustomCard(
                                        child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(tinier),
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: xxTinierSpacing),
                                              child: Text(
                                                  checklistData[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .small
                                                      .copyWith(
                                                          color:
                                                              AppColor.black)),
                                            ),
                                            subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${checklistData[index].categoryname} -- ${checklistData[index].subcategoryname.toString()}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .xSmall
                                                          .copyWith(
                                                              color: AppColor
                                                                  .grey)),
                                                  const SizedBox(
                                                      height: xxTinySpacing),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Visibility(
                                                          visible: checklistData[
                                                                      index]
                                                                  .responsecount !=
                                                              0,
                                                          child: const CustomTagContainer(
                                                              color: AppColor
                                                                  .lightGreen,
                                                              textValue:
                                                                  StringConstants
                                                                      .kResponded),
                                                        ),
                                                        const SizedBox(
                                                            width: tiniest),
                                                        Visibility(
                                                            visible: checklistData[
                                                                        index]
                                                                    .approvalpendingcount !=
                                                                0,
                                                            child: const Icon(
                                                                Icons
                                                                    .question_mark_outlined,
                                                                color: AppColor
                                                                    .errorRed,
                                                                size:
                                                                    kIconSize))
                                                      ])
                                                ]),
                                            onTap: () {
                                              context.read<ChecklistBloc>().add(
                                                  FetchChecklistScheduleDates(
                                                      checklistId:
                                                          checklistData[index]
                                                              .id,
                                                      allChecklistDataMap: {}));
                                            }));
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                        height: xxTinySpacing);
                                  }));
                        }),
                  ],
                ),
              ),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
