import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/selectLanguage/select_language_bloc.dart';
import '../../../blocs/selectLanguage/select_language_events.dart';
import '../../../utils/constants/string_constants.dart';
import 'error_section.dart';

class ShowError extends StatelessWidget {
  const ShowError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ErrorSection(
            onPressed: () {
              context.read<LanguageBloc>().add(FetchLanguageEvent());
            },
            textValue: StringConstants.kReload)
      ],
    );
  }
}
