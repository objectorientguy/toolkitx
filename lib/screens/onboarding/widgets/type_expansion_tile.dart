import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/user_type_emun.dart';

class UserTypeExpansionTile extends StatelessWidget {
  final String typeValue;
  final String typeUser;

  const UserTypeExpansionTile(
      {Key? key, required this.typeValue, required this.typeUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: expansionTileMargin, right: expansionTileMargin),
            collapsedBackgroundColor: AppColor.offWhite,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text(typeUser == 'null' ? 'Select' : typeUser,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: UserType.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(UserType.values.elementAt(index).type,
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: UserType.values.elementAt(index).type,
                        groupValue: typeUser,
                        onChanged: (value) {
                          value = UserType.values.elementAt(index).type;
                          context.read<LoginBloc>().add(UserTypeDropDown(
                              typeUser: value,
                              typeValue:
                                  UserType.values.elementAt(index).value));
                        });
                  })
            ]));
  }
}
