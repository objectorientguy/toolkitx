import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import '../../../blocs/language/language_bloc.dart';
import '../../../blocs/language/language_events.dart';
import '../../../blocs/language/language_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../selectTimeZone/select_time_zone_screen.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/error_section.dart';
import '../widgets/language_initializing.dart';
import '../widgets/select_language_body.dart';

class SelectLanguageScreen extends StatelessWidget {
  static const routeName = 'SelectLanguageScreen';

  const SelectLanguageScreen({Key? key}) : super(key: key);

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
                currentState is LanguagesLoading ||
                currentState is LanguagesLoaded,
            listener: (context, state) {
              if (state is LanguageKeysLoading) {
                LanguageInitializing.show(context);
              }
              if (state is LanguageKeysLoaded) {
                LanguageInitializing.dismiss(context);
                Navigator.pushNamed(context, SelectTimeZoneScreen.routeName);
              }
              if (state is LanguageKeysError) {
                LanguageInitializing.dismiss(context);
                showCustomSnackBar(context, "Please select language again", '');
              }
            },
            builder: (context, state) {
              if (state is LanguagesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LanguagesLoaded) {
                return SelectLanguageBody(
                    getLanguagesData: state.getLanguagesModel.data!);
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
