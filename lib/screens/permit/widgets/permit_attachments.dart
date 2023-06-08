import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../widgets/custom_card.dart';

class PermitAttachments extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitAttachments({Key? key, required this.permitDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: permitDetailsModel.data.tab5.length,
        itemBuilder: (context, index) {
          return CustomCard(
            child: Padding(
              padding: const EdgeInsets.only(top: xxTinierSpacing),
              child: ListTile(
                title: Text(permitDetailsModel.data.tab5[index].name,
                    style: Theme.of(context).textTheme.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.mediumBlack)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(permitDetailsModel.data.tab5[index].type),
                      const SizedBox(height: xxTinierSpacing),
                      Text(permitDetailsModel.data.tab5[index].files,
                          style: Theme.of(context)
                              .textTheme
                              .xxSmall
                              .copyWith(color: AppColor.deepBlue)),
                      const SizedBox(height: xxTiniestSpacing),
                    ],
                  ),
                ),
                trailing: const Icon(
                  Icons.attach_file,
                  size: kIconSize,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
