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

class CategoryScreen extends StatefulWidget {
  static const routeName = 'CategoryScreen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List selectedCategory = [];
  final List categoryList = [
    {
      'title': 'Assets',
      'items': ['spill/leak', 'Dispose']
    },
    {
      'title': 'Environment',
      'items': [
        'Restricted work',
        'fatality',
        'Adverse weather',
        'Air pollution',
        'Air pollution & emission'
      ]
    },
    {
      'title': 'Other',
      'items': ['Information', 'Process']
    },
    {
      'title': 'People',
      'items': ['Medical treatment']
    },
    {
      'title': 'Reputation',
      'items': ['Assets']
    }
  ]; // List will be removed while integrating API

  void checkBoxChange(bool isSelected, int index, int itemIndex) {
    setState(() {
      if (isSelected) {
        selectedCategory.add(categoryList[index]['items'][itemIndex]);
      } else {
        selectedCategory.remove(categoryList[index]['items'][itemIndex]);
      }
    });
  }

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
              return const CircularProgressIndicator();
            } else if (state is IncidentCategoryFetched) {
              return Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.fetchIncidentMasterModel.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categoryList[index]['title'],
                                  style: Theme.of(context)
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
                                      categoryList[index]['items'].length,
                                  itemBuilder:
                                      (BuildContext context, int itemIndex) {
                                    return CheckboxListTile(
                                        checkColor: AppColor.white,
                                        activeColor: AppColor.deepBlue,
                                        contentPadding: EdgeInsets.zero,
                                        value: selectedCategory.contains(
                                            categoryList[index]['items']
                                                [itemIndex]),
                                        title: Text(
                                            categoryList[index]['items']
                                                [itemIndex],
                                            style: Theme.of(context)
                                                .textTheme
                                                .mediumLarge
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.grey)),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        onChanged: (isChecked) {
                                          checkBoxChange(
                                              isChecked!, index, itemIndex);
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
          const SizedBox(height: xxxSmallerSpacing),
          PrimaryButton(
              onPressed: () {},
              textValue: DatabaseUtil.getText('nextButtonText')),
          const SizedBox(height: xxTinySpacing)
        ]),
      ),
    );
  }
}
