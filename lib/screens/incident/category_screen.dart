import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = 'CategoryScreen';
  static List multiSelectList = [];

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(FetchIncidentCategory(
        role: context.read<IncidentFetchAndChangeRoleBloc>().roleId));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kCategory),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(DatabaseUtil.getText('SelectcategoryHeading'),
              style: Theme.of(context)
                  .textTheme
                  .mediumLarge
                  .copyWith(fontWeight: FontWeight.w400)),
          const SizedBox(height: xxTinySpacing),
          BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
              builder: (context, state) {
            if (state is FetchingIncidentCategory) {
              return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height / 3.5),
                  child: const Center(child: CircularProgressIndicator()));
            } else if (state is IncidentCategoryFetched) {
              multiSelectList.addAll(state.categorySelectedList);
              state.addNewIncidentMap['category'] = multiSelectList
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "");
              return Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.categoryList.length,
                      itemBuilder: (context, index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.categoryList[index]['title'],
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .mediumLarge
                                      .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.greyBlack)),
                              const SizedBox(height: xxTiniestSpacing),
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                  state.categoryList[index]['items'].length,
                                  itemBuilder:
                                      (BuildContext context, int itemIndex) {
                                    return CheckboxListTile(
                                        checkColor: AppColor.white,
                                        activeColor: AppColor.deepBlue,
                                        contentPadding: EdgeInsets.zero,
                                        value: multiSelectList.contains(
                                            state.categoryList[index]['items']
                                            [itemIndex]),
                                        title: Text(
                                            state.categoryList[index]['items']
                                            [itemIndex],
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .mediumLarge
                                                .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.grey)),
                                        controlAffinity:
                                        ListTileControlAffinity.trailing,
                                        onChanged: (value) {
                                          context
                                              .read<ReportNewIncidentBloc>()
                                              .add(SelectIncidentCategory(
                                              index: index,
                                              itemIndex: itemIndex,
                                              fetchIncidentMasterModel: state
                                                  .fetchIncidentMasterModel,
                                              isSelected: value!,
                                              multiSelectList:
                                              multiSelectList));
                                        });
                                  }),
                              const SizedBox(height: xxTiniestSpacing)
                            ]);
                      }));
            } else if (state is IncidentCategoryNotFetched) {
              return GenericReloadButton(
                  onPressed: () {}, textValue: StringConstants.kReload);
            } else {
              return const SizedBox();
            }
              }),
          const SizedBox(height: xxxSmallerSpacing)
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: PrimaryButton(
              onPressed: () {},
              textValue: DatabaseUtil.getText('nextButtonText'))),
    );
  }
}
