import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/role/role_bloc.dart';
import '../../blocs/role/role_events.dart';
import '../../blocs/role/role_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/permit/permit_roles_model.dart';
import '../../widgets/generic_app_bar.dart';

class GetPermitRolesScreen extends StatelessWidget {
  static const routeName = 'GetPermitRolesScreen';

  const GetPermitRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PermitRoleBloc>().add(const GetPermitRoles());
    return Scaffold(
      appBar: const GenericAppBar(title: 'Get Roles'),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: midTiniestSpacing,
            bottom: midTiniestSpacing),
        child: BlocBuilder<PermitRoleBloc, PermitRoleStates>(
            builder: (context, state) {
          if (state is FetchingPermitRoles) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PermitRolesFetched) {
            return Builder(builder: (context) {
              return ListView.builder(
                itemCount: state.permitRolesModel.data!.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    dense: true,
                    activeColor: AppColor.deepBlue,
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(state.permitRolesModel.data![index].groupName
                        .toString()),
                    value: state.permitRolesModel.data![index],
                    groupValue: state.permitRolesModel.data![index],
                    onChanged: (value) {
                      context
                          .read<PermitRoleBloc>()
                          .add(SelectCheckBoxEvent(value as Datum));
                    },
                  );
                },
              );
            });
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
