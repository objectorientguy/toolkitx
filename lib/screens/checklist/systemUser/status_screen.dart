import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../data/models/encrypt_data.dart';
import '../../../widgets/progress_bar.dart';
import '../../onboarding/widgets/show_error.dart';
import '../widgets/pop_up_menu.dart';
import '../widgets/status_section.dart';

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
                        BlocConsumer<ChecklistBloc, ChecklistStates>(
                            buildWhen: (previousState, currentState) =>
                            currentState is ChecklistStatusFetched,
                            listener: (context, state) {
                              if (state is FetchingPdf) {
                                ProgressBar.show(context);
                              } else if (state is PdfFetched) {
                                ProgressBar.dismiss(context);
                            var encrypted = EncryptData.decryptAES(
                                state.getPdfModel.message,
                                "vbdvrj9aN/gnmG9HRZBOV137+VBlDH1innvdsfSI8lOHTShvQP8iAcfeuRbflSG0");
                            log("encrypted=====>$encrypted");
                            launchUrlString(
                              '${ApiConstants.baseDocsUrl}workforcereport_638207770440797781.pdf}',
                              mode: LaunchMode.inAppWebView,
                            );
                          } else if (state is FetchPdfError) {
                                showCustomSnackBar(
                                    context,
                                    StringConstants.kSomethingWentWrong,
                                    StringConstants.kOk);
                              }
                            },
                            builder: (context, state) {
                              if (state is ChecklistStatusFetched) {
                                return SystemUserStatusSection(
                                    getChecklistStatusModel:
                                    state.getChecklistStatusModel);
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
