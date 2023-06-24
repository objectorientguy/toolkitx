import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';

import 'package:toolkit/screens/permit/get_permit_roles_screen.dart';
import 'package:toolkit/screens/permit/permit_filter_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/text_button.dart';
import 'widgets/permit_list_tile.dart';

class PermitListScreen extends StatelessWidget {
  static const routeName = 'PermitListScreen';
  final bool isFromHome;

  const PermitListScreen({Key? key, this.isFromHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(GetAllPermits(isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('PermitToWork')),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocBuilder<PermitBloc, PermitStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is AllPermitsFetched,
                    builder: (context, state) {
                      if (state is AllPermitsFetched) {
                        return Visibility(
                            visible: state.filters.toString() != '{}',
                            child: CustomTextButton(
                                onPressed: () {
                                  context
                                      .read<PermitBloc>()
                                      .add(const ClearPermitFilters());
                                  context.read<PermitBloc>().add(
                                      GetAllPermits(isFromHome: isFromHome));
                                },
                                textValue: DatabaseUtil.getText('Clear')));
                      } else {
                        return const SizedBox();
                      }
                    }),
                CustomIconButtonRow(
                    isEnabled: true,
                    primaryOnPress: () {
                      Navigator.pushNamed(
                          context, PermitFilterScreen.routeName);
                    },
                    secondaryOnPress: () {
                      Navigator.pushNamed(
                          context, GetPermitRolesScreen.routeName);
                    },
                    clearOnPress: () {})
              ]),
              const SizedBox(height: xxTinierSpacing),
              const PermitListTile()
            ],
          ),
        ));
  }
}
