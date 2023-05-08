import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/selectYourLanguage/select_your_language_bloc.dart';
import 'package:toolkit/blocs/selectYourLanguage/select_your_language_events.dart';
import 'package:toolkit/blocs/selectYourLanguage/select_your_language_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../widgets/card_widget.dart';

class SelectYourLanguageScreen extends StatelessWidget {
  const SelectYourLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LanguageBloc>().add(FetchLanguageEvent());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kSelectYourLanguage,
              style: Theme.of(context).textTheme.largeTitle),
          const SizedBox(height: tinySpacing),
          BlocConsumer<LanguageBloc, LanguageStates>(
              listener: (context, state) {
            if (state is FetchLanguageError) {
              Navigator.pop(context);
            }
          }, builder: (context, state) {
            if (state is FetchLanguageLoading) {
              return const CircularProgressIndicator();
            } else if (state is FetchLanguageLoaded) {
              return Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.languageModel.data!.length,
                      itemBuilder: (context, index) {
                        return CardWidget(
                            margin: EdgeInsets.zero,
                            elevation: kCardElevation,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(tiniestSpacing)),
                            child: ListTile(
                                onTap: () {},
                                leading: Image.network(
                                    "https://pandoraict.com/breedapp/images/flags/${state.languageModel.data![index].flagName}",
                                    height: MediaQuery.of(context).size.width *
                                        0.08),
                                title: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: tiniestSpacing),
                                    child: Text(state
                                        .languageModel.data![index].langName
                                        .toString()))));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: tinySpacing);
                      }));
            } else {
              return Container();
            }
          }),
        ]),
      ),
    );
  }
}
