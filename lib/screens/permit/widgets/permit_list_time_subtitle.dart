import 'package:flutter/material.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/all_permits_model.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../widgets/icon_and_text_row.dart';
import '../../../widgets/status_tag.dart';
import 'date_time.dart';

class PermitListTimeSubtitle extends StatelessWidget {
  final AllPermitDatum allPermitDatum;

  const PermitListTimeSubtitle({super.key, required this.allPermitDatum});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: tinier),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(allPermitDatum.description!, maxLines: 3),
              const SizedBox(height: tinier),
              Row(children: [
                Image.asset('assets/icons/location.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniest),
                Flexible(child: Text(allPermitDatum.location!, maxLines: 3))
              ]),
              const SizedBox(height: tinier),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconAndTextRow(
                        title: allPermitDatum.pname!,
                        icon: 'human_avatar_three'),
                    IconAndTextRow(
                        title: allPermitDatum.pcompany!, icon: 'office')
                  ]),
              const SizedBox(height: tinier),
              DateTimeRow(allPermitDatum: allPermitDatum),
              const SizedBox(height: tinier),
              StatusTag(tags: [
                StatusTagModel(
                    title: (allPermitDatum.expired == '2') ? 'Expired' : '',
                    bgColor: AppColor.errorRed),
                StatusTagModel(
                    title: (allPermitDatum.npiStatus == '1') ? 'NPI' : '',
                    bgColor: AppColor.yellow),
                StatusTagModel(
                    title: (allPermitDatum.npwStatus == '1') ? 'NPW' : '',
                    bgColor: AppColor.yellow)
              ])
            ]));
  }
}
