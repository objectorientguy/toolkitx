import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_events.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/checklist/change_role_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/filters_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../widgets/progree_bar.dart';
import 'details_screen.dart';
import 'list_section.dart';

class ChecklistScreen extends StatelessWidget {
  static const routeName = 'ChecklistScreen';

  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChecklistBloc>().add(FetchChecklist());
    return Scaffold(
        appBar: const GenericAppBar(title: Text(StringConstants.kChecklist)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: midTiniestSpacing),
            child: Column(children: [
              CustomIconButtonRow(
                  primaryOnPress: () {
                    Navigator.pushNamed(context, FiltersScreen.routeName);
                  },
                  secondaryOnPress: () {
                    Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                  },
                  clearVisible: false,
                  clearOnPress: () {}),
              const SizedBox(height: tiniestSpacing),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    BlocConsumer<ChecklistBloc, ChecklistStates>(
                        listener: (context, state) {
                      if (state is ChecklistDetailsFetching) {
                        log("list loading");
                        ProgressBar.show(context);
                      } else if (state is ChecklistDetailsFetched) {
                        log("list loaded");
                        ProgressBar.dismiss(context);
                        Navigator.pushNamed(context, DetailsScreen.routeName);
                      }
                    }, builder: (context, state) {
                      if (state is ChecklistFetching) {
                        return const CircularProgressIndicator();
                      } else if (state is ChecklistFetched) {
                        return ChecklistListSection(
                            getChecklistModel: state.getChecklistModel);
                      } else if (state is ChecklistError) {
                        return ShowError(onPressed: () {
                          context.read<ChecklistBloc>().add(FetchChecklist());
                        });
                      } else {
                        return const SizedBox();
                          }
                        })
                      ])),
              const SizedBox(height: tinySpacing)
            ])));
  }
}
