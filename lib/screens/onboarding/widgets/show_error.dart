import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/selectYourLanguage/select_your_language_bloc.dart';
import '../../../blocs/selectYourLanguage/select_your_language_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';

class ShowError extends StatelessWidget {
  const ShowError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/error_image.png",
            height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            color: AppColor.deepBlue),
        const SizedBox(height: tinySpacing),
        ElevatedButton(
          onPressed: () {
            context.read<LanguageBloc>().add(FetchLanguageEvent());
          },
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.height * 0.12,
                  MediaQuery.of(context).size.width * 0.1),
              backgroundColor: AppColor.deepBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kCardRadius),
              )),
          child: const Text(StringConstants.kReload),
        ),
      ],
    );
  }
}
