import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/systemUser/checklist/list_model.dart';

class DetailsLabelSection extends StatelessWidget {
  final GetChecklistData getChecklistData;

  const DetailsLabelSection({Key? key, required this.getChecklistData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Visibility(
        visible: getChecklistData.responsecount != 0,
        child: Container(
            padding: const EdgeInsets.all(tiniestSpacing),
            decoration: BoxDecoration(
                color: AppColor.lightGreen,
                borderRadius: BorderRadius.circular(kCardRadius)),
            height: kTagsHeight,
            child: Text(StringConstants.kResponded,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(color: AppColor.white))),
      ),
      const SizedBox(width: tiniestSpacing),
      Visibility(
          visible: getChecklistData.approvalpendingcount != 0,
          child: const Icon(Icons.question_mark_outlined,
              color: AppColor.errorRed, size: kIconSize))
    ]);
  }
}
