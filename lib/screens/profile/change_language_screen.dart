import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/language/language_bloc.dart';
import '../../blocs/language/language_events.dart';
import '../../blocs/language/language_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_loading_popup.dart';
import '../onboarding/widgets/select_language_body.dart';

class ChangeLanguageScreen extends StatelessWidget {
  static const routeName = 'ChangeLanguageScreen';
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LanguageBloc>().add(FetchLanguages());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kSelectYourLanguage),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: BlocConsumer<LanguageBloc, LanguageStates>(
            buildWhen: (previousState, currentState) =>
                currentState is LanguagesFetching ||
                currentState is LanguagesFetched,
            listener: (context, state) {
              if (state is LanguageKeysFetching) {
                GenericLoadingPopUp.show(
                    context, StringConstants.kInitializingLanguage);
              }
              if (state is LanguageKeysFetched) {
                GenericLoadingPopUp.dismiss(context);
                Navigator.pop(context);
              }
              if (state is LanguageKeysError) {
                GenericLoadingPopUp.dismiss(context);
                showCustomSnackBar(
                    context, StringConstants.kSelectLanguageAgain, '');
              }
            },
            builder: (context, state) {
              if (state is LanguagesFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LanguagesFetched) {
                return SelectLanguageBody(
                    getLanguagesData: state.languagesModel.data!);
              } else if (state is LanguagesError) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context.read<LanguageBloc>().add(FetchLanguages());
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
