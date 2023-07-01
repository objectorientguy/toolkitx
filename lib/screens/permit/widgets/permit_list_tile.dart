import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import 'permit_list_tile_title.dart';
import 'permit_list_time_subtitle.dart';

class PermitListTile extends StatelessWidget {
  const PermitListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermitBloc, PermitStates>(
        buildWhen: (previousState, currentState) =>
            (currentState is AllPermitsFetched ||
                currentState is FetchingAllPermits),
        builder: (context, state) {
          if (state is AllPermitsFetched) {
            if (state.allPermitModel.data!.isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.allPermitModel.data!.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: tinierSpacing),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          PermitDetailsScreen.routeName,
                                          arguments: state
                                              .allPermitModel.data![index].id);
                                    },
                                    title: PermitListTileTitle(
                                        allPermitDatum:
                                            state.allPermitModel.data![index]),
                                    subtitle: PermitListTimeSubtitle(
                                        allPermitDatum: state
                                            .allPermitModel.data![index]))));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinierSpacing);
                      }));
            } else {
              if (state.filters.isEmpty) {
                return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: Text(DatabaseUtil.getText('no_records_found'))));
              } else {
                return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: const Text(StringConstants.kNoRecordsFilter)));
              }
            }
          } else if (state is FetchingAllPermits) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          } else {
            return const SizedBox();
          }
        });
  }
}
