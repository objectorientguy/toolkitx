import 'dart:math';

import 'package:flutter/material.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../utils/permit_util.dart';
import '../../../widgets/custom_card.dart';

class PermitGroup extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitGroup({Key? key, required this.permitDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          final random = Random();
          final leadingAvatarIcon = PermitUtil().leadingAvatarList[
              random.nextInt(PermitUtil().leadingAvatarList.length)];
          return CustomCard(
            child: Padding(
              padding: const EdgeInsets.only(top: xxTinierSpacing),
              child: ListTile(
                leading: Image.asset(
                  leadingAvatarIcon,
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Martin Smith'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.050,
                      decoration: BoxDecoration(
                        color: AppColor.lightGreen,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Valid',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Crane Supervisor',
                      ),
                      SizedBox(height: xxTinierSpacing),
                      Text('ToolkitX Test Workforce'),
                      SizedBox(height: xxTinierSpacing),
                    ],
                  ),
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
