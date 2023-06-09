import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/encrypt_data.dart';
import '../../../widgets/progress_bar.dart';
import '../widgets/checklist_app_bar.dart';
import '../widgets/pop_up_menu.dart';
import '../widgets/workforce_list_section.dart';

class ChecklistWorkForceListScreen extends StatelessWidget {
  static const routeName = 'ChecklistWorkForceListScreen';

  const ChecklistWorkForceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChecklistAppBar(
            title: BlocBuilder<ChecklistBloc, ChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is ChecklistWorkforceListFetched,
                builder: (context, state) {
                  if (state is ChecklistWorkforceListFetched) {
                    return Text(
                        state.getChecklistStatusModel.data![0].checklistname);
                  } else {
                    return const SizedBox();
                  }
                }),
            actions: [
              BlocBuilder<ChecklistBloc, ChecklistStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is ChecklistWorkforceListFetched,
                  builder: (context, state) {
                    if (state is FetchingChecklistWorkforceList) {
                      return const CircularProgressIndicator();
                    } else if (state is ChecklistWorkforceListFetched) {
                      return PopUpMenu(
                          responseIdList: state.selectedIdsList,
                          scheduleId: state.allChecklistDataMap["scheduleId"],
                          popUpMenuBuilder: state.popUpMenuBuilder);
                    } else {
                      return const SizedBox();
                    }
                  })
            ]),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: Column(children: [
              BlocBuilder<ChecklistBloc, ChecklistStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is ChecklistWorkforceListFetched,
                  builder: (context, state) {
                    if (state is ChecklistWorkforceListFetched) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Image.asset("assets/icons/calendar.png",
                                height: kProfileImageHeight,
                                width: kProfileImageWidth),
                            const SizedBox(width: xxTinierSpacing),
                            Text(
                                '${state.getChecklistStatusModel.data![0].startdate} - ${state.getChecklistStatusModel.data![0].enddate}',
                                style: Theme.of(context).textTheme.xSmall),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
              const SizedBox(height: xxTinySpacing),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    BlocConsumer<ChecklistBloc, ChecklistStates>(
                        buildWhen: (previousState, currentState) =>
                            currentState is ChecklistWorkforceListFetched,
                        listener: (context, state) {
                          if (state is FetchingPdf) {
                            ProgressBar.show(context);
                          } else if (state is PdfFetched) {
                            ProgressBar.dismiss(context);
                            var decrypted = EncryptData.decryptAES(
                                state.getPdfModel.message,
                                "SvwH32gnWK1slqvskIsSg9duoVfgOQLWitcfZGr+n2KX1yltKm2T+EbsIhBm0E6B");
                            launchUrlString(
                              '${ApiConstants.baseDocUrl}$decrypted.pdf',
                              mode: LaunchMode.externalApplication,
                            );
                          } else if (state is FetchPdfError) {
                            showCustomSnackBar(
                                context,
                                StringConstants.kSomethingWentWrong,
                                StringConstants.kOk);
                          }
                        },
                        builder: (context, state) {
                          if (state is ChecklistWorkforceListFetched) {
                            return SystemUserWorkForceListSection(
                                getChecklistStatusModel:
                                    state.getChecklistStatusModel,
                                selectedStatusList: state.selectedIdsList);
                          } else if (state is ChecklistWorkforceListError) {
                            return GenericReloadButton(
                              onPressed: () {},
                              textValue: StringConstants.kReload,
                            );
                          } else {
                            return const SizedBox();
                          }
                        })
                  ]))
            ])));
  }
}
