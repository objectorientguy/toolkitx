import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';

import '../configs/app_spacing.dart';
import '../data/models/status_tag_model.dart';

class StatusTag extends StatelessWidget {
  final List<StatusTagModel>? tags;

  const StatusTag({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.080,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: tags!.length,
          itemBuilder: (context, index) {
            return (tags![index].title! != '')
                ? Container(
                    decoration: BoxDecoration(
                      color: tags![index].bgColor,
                      borderRadius: BorderRadius.circular(kCardRadius),
                    ),
                    margin:
                        const EdgeInsets.only(right: tiniest, bottom: tiniest),
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.all(tiniest),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.040,
                          child: Text(
                            tags![index].title!,
                            style: const TextStyle(color: AppColor.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  )
                : const SizedBox();
          }),
    );
  }
}
