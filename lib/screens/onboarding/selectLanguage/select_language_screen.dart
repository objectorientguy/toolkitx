import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import '../../../blocs/selectLanguage/select_language_bloc.dart';
import '../../../blocs/selectLanguage/select_language_events.dart';
import '../../../blocs/selectLanguage/select_language_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../selectTimeZone/select_time_zone_screen.dart';
import '../widgets/custom_card.dart';
import '../widgets/onboarding_app_bar.dart';

class SelectLanguageScreen extends StatelessWidget {
  static const routeName = 'SelectLanguageScreen';

  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LanguageBloc>().add(FetchLanguageEvent());
    return Scaffold(
      appBar: const OnBoardingAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(StringConstants.kSelectYourLanguage,
                style: Theme.of(context).textTheme.largeTitle),
          ),
          const SizedBox(height: tinySpacing),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<LanguageBloc, LanguageStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is LanguagesLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is LanguagesLoaded) {
                        return Expanded(
                            child: ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.languageModel.data!.length,
                                itemBuilder: (context, index) {
                                  return CustomCard(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              kCardRadius)),
                                      child: ListTile(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                SelectTimeZoneScreen.routeName);
                                          },
                                          leading: Image.network(
                                              "https://pandoraict.com/breedapp/images/flags/${state.languageModel.data![index].flagName}",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08),
                                          title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: tiniestSpacing),
                                              child: Text(state.languageModel
                                                  .data![index].langName))));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(height: tinySpacing);
                                }));
                      } else if (state is LanguagesError) {
                        return const ShowError();
                      } else {
                        return const SizedBox();
                      }
                    }),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
