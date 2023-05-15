import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'widgets/edit_options.dart';
import 'widgets/profile_options.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(height: largeSpacing),
                  EditOptions(),
                  SizedBox(height: tinySpacing),
                  ProfileOptions()
                ])));
  }
}
