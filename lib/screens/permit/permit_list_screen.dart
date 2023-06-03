import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';

import 'package:toolkit/screens/permit/get_permit_roles_screen.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import 'widgets/permit_list_tile.dart';

class PermitListScreen extends StatelessWidget {
  static const routeName = 'PermitListScreen';

  const PermitListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(const GetAllPermits());
    return Scaffold(
        appBar: const GenericAppBar(title: 'Permit To Work'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: midTiniestSpacing),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomIconButtonRow(
                isEnabled: true,
                primaryOnPress: () {},
                secondaryOnPress: () {
                  Navigator.pushNamed(context, GetPermitRolesScreen.routeName);
                },
                clearOnPress: () {}),
            const SizedBox(height: midTiniestSpacing),
            const PermitListTile(),
          ]),
        ));
  }
}
