import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'widgets/edit_options.dart';
import 'widgets/profile_options.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(height: xxxSmallerSpacing),
                      EditOptions(),
                      SizedBox(height: xxTinySpacing),
                      ProfileOptions()
                    ]))));
  }
}
