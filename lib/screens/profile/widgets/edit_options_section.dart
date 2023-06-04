import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/client/client_bloc.dart';
import 'package:toolkit/blocs/client/client_events.dart';
import 'package:toolkit/blocs/profile/profile_bloc.dart';
import 'package:toolkit/blocs/profile/profile_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/client_list_screen.dart';
import 'package:toolkit/screens/profile/edit/profile_edit_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/profile/user_profile_model.dart';
import '../../../utils/profile_util.dart';

class EditOptionsSection extends StatelessWidget {
  final UserProfileData userprofileDetails;

  const EditOptionsSection({Key? key, required this.userprofileDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProfileEditScreen.routeName);
            context.read<ProfileBloc>().add(DecryptUserProfileData(
                userprofileDetails: userprofileDetails.toJson()));
          },
          child: Column(children: [
            Image.asset('${ProfileUtil.iconPath}' 'pen.png',
                height: kProfileImageHeight, width: kProfileImageWidth),
            const SizedBox(height: xxTiniestSpacing),
            Text(DatabaseUtil.getText('EditProfile'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.xxSmall)
          ])),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ClientListScreen.routeName);
            context.read<ClientBloc>().add(FetchClientList());
          },
          child: Column(children: [
            Image.asset('${ProfileUtil.iconPath}' 'exchange.png',
                height: kProfileImageHeight, width: kProfileImageWidth),
            const SizedBox(height: xxTiniestSpacing),
            Text(DatabaseUtil.getText('ChangeClient'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.xxSmall)
          ])),
      GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AndroidPopUp(
                      titleValue: DatabaseUtil.getText('Logout'),
                      contentValue: DatabaseUtil.getText('LogoutMessage'),
                      onPressed: () {
                        Navigator.of(context);
                        context.read<ProfileBloc>().add(Logout());
                      });
                });
          },
          child: Column(children: [
            Image.asset('${ProfileUtil.iconPath}' 'logout.png',
                height: kProfileImageHeight, width: kProfileImageWidth),
            const SizedBox(height: xxTiniestSpacing),
            Text(DatabaseUtil.getText('Logout') ,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.xxSmall)
          ]))
    ]);
  }
}
