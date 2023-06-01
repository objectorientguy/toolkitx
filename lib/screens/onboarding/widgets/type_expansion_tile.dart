import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/password/password_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/password/password_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';

class UserTypeExpansionTile extends StatelessWidget {
  final String typeValue;

  UserTypeExpansionTile({Key? key, required this.typeValue}) : super(key: key);
  final List userTypeList = [
    StringConstants.kWorkforce,
    StringConstants.kSystemUser
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: kExpansionTileMargin, right: kExpansionTileMargin),
            collapsedBackgroundColor: AppColor.offWhite,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text(typeValue == 'null' ? 'Select' : typeValue,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(userTypeList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: userTypeList[index],
                        groupValue: typeValue,
                        onChanged: (value) {
                          value = userTypeList[index];
                          context
                              .read<PasswordBloc>()
                              .add(UserTypeDropDown(typeValue: value));
                        });
                  })
            ]));
  }
}
