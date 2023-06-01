import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/language/language_bloc.dart';
import '../../../blocs/language/language_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/language/languages_model.dart';
import '../../../utils/constants/api_constants.dart';
import 'custom_card.dart';

class SelectLanguageBody extends StatelessWidget {
  final List<GetLanguagesData> getLanguagesData;
  final bool isFromProfile;
  const SelectLanguageBody(
      {Key? key, required this.getLanguagesData, required this.isFromProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: getLanguagesData.length,
        itemBuilder: (context, index) {
          return CustomCard(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius)),
              child: ListTile(
                  onTap: () {
                    context.read<LanguageBloc>().add(FetchLanguageKeys(
                        languageId: getLanguagesData[index].id.toString(),
                        isFromProfile: isFromProfile));
                  },
                  minVerticalPadding: kLanguagesTileHeight,
                  leading: CachedNetworkImage(
                      height: kLanguageFlagHeight,
                      imageUrl:
                          '${ApiConstants.baseUrlFlag}${getLanguagesData[index].flagName}',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                              strokeWidth: kCircularIndicatorStrokeWidth),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline_sharp,
                          size: kIconSize)),
                  title: Text(getLanguagesData[index].langName)));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: midTiniestSpacing);
        });
  }
}
