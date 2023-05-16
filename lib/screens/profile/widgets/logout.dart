import 'package:flutter/cupertino.dart';
import '../../../utils/constants/string_constants.dart';
import '../../onboarding/welcome_screen.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(StringConstants.kLogout),
      content: const Text(StringConstants.kLogoutDialogContent),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(StringConstants.kNo),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                WelcomeScreen.routeName, (Route<dynamic> route) => false);
          },
          child: const Text(StringConstants.kYes),
        ),
      ],
    );
  }
}
