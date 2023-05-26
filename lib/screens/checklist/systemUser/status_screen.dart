import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../configs/app_color.dart';
import '../../onboarding/widgets/show_error.dart';
import '../widgets/pop_up_menu.dart';

class ChecklistStatusScreen extends StatelessWidget {
  static const routeName = 'ChecklistStatusScreen';

  const ChecklistStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: BlocBuilder<ChecklistBloc, ChecklistStates>(
                builder: (context, state) {
              if (state is ChecklistStatusFetched) {
                return Text(
                    state.getChecklistStatusModel.data![0].checklistname);
              } else {
                return const SizedBox();
              }
            }),
            actions: const [PopUpMenu()]),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: Column(children: [
              BlocBuilder<ChecklistBloc, ChecklistStates>(
                  builder: (context, state) {
                if (state is ChecklistStatusFetched) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        '${state.getChecklistStatusModel.data![0].startdate} - ${state.getChecklistStatusModel.data![0].enddate}',
                        style: Theme.of(context).textTheme.xSmall),
                  );
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(height: tinySpacing),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    BlocBuilder<ChecklistBloc, ChecklistStates>(
                        builder: (context, state) {
                      if (state is ChecklistStatusFetched) {
                        return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  state.getChecklistStatusModel.data!.length,
                              itemBuilder: (context, index) {
                                return CustomCard(
                                    child: ListTile(
                                        contentPadding: const EdgeInsets.all(
                                            midTinySpacing),
                                        title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: tiniestSpacing),
                                            child: Text(
                                                state.getChecklistStatusModel
                                                    .data![index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .small
                                                    .copyWith(
                                                        color:
                                                            AppColor.black))),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${state.getChecklistStatusModel.data![index].jobtitle} ${state.getChecklistStatusModel.data![index].company}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .xSmall
                                                      .copyWith(
                                                          color:
                                                              AppColor.grey)),
                                              const SizedBox(
                                                  height: tiniestSpacing),
                                              Text(
                                                  'Response Date: ${state.getChecklistStatusModel.data![index].responsedate}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .xSmall
                                                      .copyWith(
                                                          color:
                                                              AppColor.grey)),
                                              const SizedBox(
                                                  height: tiniestSpacing),
                                              Text('Approved',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .xSmall
                                                      .copyWith(
                                                          color: AppColor.grey))
                                            ]),
                                        trailing: IconButton(
                                            padding: EdgeInsets.zero,
                                            // This code will get removed when the changes will be pushed to dev
                                            constraints: const BoxConstraints(),
                                            // This code will get removed when the changes will be pushed to dev.
                                            iconSize: kIconSize,
                                            // This code will get removed when the changes will be pushed to dev
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.attach_file_outlined))));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: tinySpacing);
                              }),
                        );
                      } else if (state is ChecklistStatusError) {
                        return ShowError(
                          onPressed: () {},
                        );
                      } else {
                        return const SizedBox();
                      }
                    })
                  ]))
            ])));
  }
}
