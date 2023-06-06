import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_events.dart';
import '../../../configs/app_color.dart';
import '../../../data/enums/user_type_emun.dart';

class UserTypeExpansionTile extends StatelessWidget {
  final String typeValue;
  final String usertype;

  const UserTypeExpansionTile(
      {Key? key, required this.typeValue, required this.usertype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title: Text(usertype == 'null' ? 'Select' : usertype,
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
                        groupValue: usertype,
                        onChanged: (value) {
                          value = UserType.values.elementAt(index).type;
                          context.read<LoginBloc>().add(ChangeUserType(
                              userType: value,
                              typeValue:
                                  UserType.values.elementAt(index).value));
                        });
                  })
            ]));
  }
}
