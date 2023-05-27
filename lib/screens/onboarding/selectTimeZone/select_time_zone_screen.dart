import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/timeZone/time_zone_bloc.dart';
import '../../../blocs/timeZone/time_zone_events.dart';
import '../../../blocs/timeZone/time_zone_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../selectDateFormat/select_date_format_screen.dart';
import '../../../widgets/generic_app_bar.dart';
import '../widgets/custom_card.dart';
import '../../../widgets/error_section.dart';

class SelectTimeZoneScreen extends StatelessWidget {
  static const routeName = 'SelectTimeZoneScreen';

  const SelectTimeZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TimeZoneBloc>().add(FetchTimeZone());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectTimeZone),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomSpacing),
          child: BlocConsumer<TimeZoneBloc, TimeZoneStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is TimeZoneLoading ||
                  currentState is TimeZoneLoaded,
              listener: (context, state) {
                if (state is SelectTimeZoneLoaded) {
                  Navigator.pushNamed(
                      context, SelectDateFormatScreen.routeName);
                }
              },
              builder: (context, state) {
                if (state is TimeZoneLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TimeZoneLoaded) {
                  return ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.getTimeZoneModel.data!.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kCardRadius)),
                            child: ListTile(
                                onTap: () {
                                  context.read<TimeZoneBloc>().add(
                                      SelectTimeZone(
                                          timeZoneCode: state.getTimeZoneModel
                                              .data![index].code));
                                },
                                leading:
                                    const Icon(Icons.public, size: kIconSize),
                                title: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: tiniestSpacing),
                                    child: Text(state
                                        .getTimeZoneModel.data![index].offset)),
                                subtitle: Text(
                                    state.getTimeZoneModel.data![index].name)));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: midTiniestSpacing);
                      });
                } else if (state is TimeZoneError) {
                  return Center(
                      child: GenericReloadButton(
                          onPressed: () {
                            context.read<TimeZoneBloc>().add(FetchTimeZone());
                          },
                          textValue: StringConstants.kReload));
                } else {
                  return const SizedBox();
                }
              }),
        ));
  }
}
