import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_events.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/report_incident/report_incident_screen.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/primary_button.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = 'CategoryScreen';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<ReportIncidentBloc>().add(SelectCategory(
          selectedCategory: [],
        ));
    return Scaffold(
      appBar: const GenericAppBar(title: Text(StringConstants.kCategory)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kSelectCategoryIncident,
              style: Theme.of(context)
                  .textTheme
                  .mediumLarge
                  .copyWith(fontWeight: FontWeight.w400)),
          const SizedBox(height: tinySpacing),
          BlocBuilder<ReportIncidentBloc, ReportIncidentStates>(
              builder: (context, state) {
            if (state is SelectCategoryLoaded) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.category.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.category[index]['title'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .mediumLarge
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.greyBlack)),
                                    const SizedBox(height: tiniestSpacing),
                                    ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state
                                            .category[index]['items'].length,
                                        itemBuilder: (BuildContext context,
                                            int itemIndex) {
                                          return CheckboxListTile(
                                              checkColor: AppColor.white,
                                              activeColor: AppColor.deepBlue,
                                              contentPadding: EdgeInsets.zero,
                                              value: state.selectedCategory
                                                  .contains(state.category[index]
                                                      ['items'][itemIndex]),
                                              title: Text(
                                                  state.category[index]['items']
                                                      [itemIndex],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .mediumLarge
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              AppColor.grey)),
                                              controlAffinity:
                                                  ListTileControlAffinity.trailing,
                                              onChanged: (isChecked) {
                                                context
                                                    .read<ReportIncidentBloc>()
                                                    .add(SelectCategory(
                                                        selectedCategory: state
                                                            .selectedCategory,
                                                        listIndex: index,
                                                        itemIndex: itemIndex));
                                              });
                                        }),
                                    const SizedBox(height: tiniestSpacing)
                                  ]);
                            })),
                    const SizedBox(height: mediumSpacing),
                    PrimaryButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ReportIncidentScreen.routeName);
                        },
                        textValue: StringConstants.kNext),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
          const SizedBox(height: tinySpacing)
        ]),
      ),
    );
  }
}
