import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../onboarding/widgets/custom_card.dart';

class PermitAttachments extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitAttachments({Key? key, required this.permitDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return CustomCard(
            child: Padding(
              padding: const EdgeInsets.only(top: midTiniestSpacing),
              child: ListTile(
                title: const Text('RAMS-13'),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: midTiniestSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Company documents'),
                      SizedBox(height: midTiniestSpacing),
                      Text('Dummy.pdf'),
                      SizedBox(height: tiniestSpacing),
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
          return const SizedBox(height: midTiniestSpacing);
        });
  }
}
