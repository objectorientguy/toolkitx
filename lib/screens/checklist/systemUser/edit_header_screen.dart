import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/header_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/header_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/edit_header_util.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/checklist/systemUser/submitHeader/header_events.dart';
import '../widgets/checklist_app_bar.dart';

class EditHeaderScreen extends StatelessWidget {
  static const routeName = 'EditHeaderScreen';

  EditHeaderScreen({Key? key}) : super(key: key);
  final List editHeaderList = [];

  @override
  Widget build(BuildContext context) {
    context.read<HeaderBloc>().add(FetchEditHeader(
        scheduleId: context.read<ScheduleDatesResponseBloc>().scheduleId));
    return Scaffold(
        appBar: ChecklistAppBar(
            title: BlocBuilder<HeaderBloc, HeaderStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingEditHeader ||
                    currentState is EditHeaderFetched ||
                    currentState is EditHeaderError,
                builder: (context, state) {
                  if (state is EditHeaderFetched) {
                    return Text(state
                        .getCheckListEditHeaderModel.data![0].checklistname);
                  } else {
                    return const SizedBox();
                  }
                })),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<HeaderBloc, HeaderStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingEditHeader ||
                    currentState is EditHeaderFetched ||
                    currentState is EditHeaderError,
                listener: (context, state) {
                  if (state is SubmittingHeader) {
                    ProgressBar.show(context);
                  } else if (state is HeaderSubmitted) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.headerMessage, '');
                  } else if (state is HeaderNotSubmitted) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, state.message, StringConstants.kOk);
                  }
                },
                builder: (context, state) {
                  if (state is FetchingEditHeader) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EditHeaderFetched) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                state.getCheckListEditHeaderModel.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: state
                                              .getCheckListEditHeaderModel
                                              .data![index]
                                              .title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .medium,
                                          children: [
                                            (state
                                                        .getCheckListEditHeaderModel
                                                        .data![index]
                                                        .ismandatory ==
                                                    1)
                                                ? TextSpan(
                                                    text: ' *',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .medium)
                                                : const TextSpan()
                                          ]),
                                    ),
                                    const SizedBox(height: xxTinierSpacing),
                                    EditHeader()
                                        .fetchEditHeaderSwitchCaseWidget(
                                            index,
                                            state.getCheckListEditHeaderModel
                                                .data![index],
                                            editHeaderList),
                                    const SizedBox(height: xxTinierSpacing),
                                  ]);
                            }),
                        const SizedBox(height: xxTinySpacing),
                        PrimaryButton(
                            onPressed: () {
                              context.read<HeaderBloc>().add(SubmitHeader(
                                  scheduleId: context
                                      .read<ScheduleDatesResponseBloc>()
                                      .scheduleId,
                                  submitHeaderList: editHeaderList));
                            },
                            textValue: StringConstants.kSubmit)
                      ]),
                    );
                  } else if (state is EditHeaderError) {
                    return GenericReloadButton(
                        onPressed: () {
                          context.read<HeaderBloc>().add(FetchEditHeader(
                              scheduleId: context
                                  .read<ScheduleDatesResponseBloc>()
                                  .scheduleId));
                        },
                        textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
