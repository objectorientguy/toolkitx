import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class ViewIncidentDetailsNetworkImage extends StatelessWidget {
  final int itemCount;
  final void Function() onTap;
  final String imageUrl;

  const ViewIncidentDetailsNetworkImage(
      {Key? key,
      required this.itemCount,
      required this.onTap,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 200 / 350,
            crossAxisCount: 4,
            crossAxisSpacing: tinier,
            mainAxisSpacing: tinier),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: onTap,
              child: CachedNetworkImage(
                  height: kCachedNetworkImageHeight,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: AppColor.white,
                      child: Container(
                          height: kNetworkImageContainerTogether,
                          width: kNetworkImageContainerTogether,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius:
                                  BorderRadius.circular(kCardRadius)))),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error_outline_sharp, size: kIconSize)));
        });
  }
}
