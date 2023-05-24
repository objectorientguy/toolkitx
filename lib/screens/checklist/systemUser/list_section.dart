import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/systemUser/checklist/list_model.dart';
import '../../onboarding/widgets/custom_card.dart';
import '../widgets/details_label_section.dart';
import 'details_screen.dart';

class ChecklistListSection extends StatelessWidget {
  final List<GetChecklistData> getChecklistData;

  const ChecklistListSection({Key? key, required this.getChecklistData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: getChecklistData.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: ListTile(
                  contentPadding: const EdgeInsets.all(midTinySpacing),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: midTiniestSpacing),
                    child: Text(getChecklistData[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .small
                            .copyWith(color: AppColor.black)),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('${getChecklistData[index].categoryname}  --',
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.grey)),
                          const SizedBox(width: tiniestSpacing),
                          Text(
                              getChecklistData[index]
                                  .subcategoryname
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.grey))
                        ]),
                        const SizedBox(height: tinySpacing),
                        DetailsLabelSection(
                            getChecklistData: getChecklistData[index])
                      ]),
                  onTap: () {
                    Navigator.pushNamed(context, DetailsScreen.routeName);
                  }));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: tinySpacing);
        });
  }
}
