import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../widgets/category_expansion_tile.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = 'FiltersScreen';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        title: Text(StringConstants.kFilters),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kChecklistName,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: midTinySpacing),
            const TextFieldWidget(),
            const SizedBox(height: midTinySpacing),
            Text(StringConstants.kCategory,
                style: Theme.of(context).textTheme.medium),
            const SizedBox(height: midTinySpacing),
            const CategoryExpansionTile(),
            const SizedBox(height: mediumSpacing),
            PrimaryButton(onPressed: () {}, textValue: StringConstants.kApply)
          ],
        ),
      ),
    );
  }
}
