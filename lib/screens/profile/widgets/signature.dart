import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';

class SignaturePad extends StatelessWidget {
  final Map profileDetailsMap;
  final SignatureController signController;

  const SignaturePad(
      {Key? key, required this.profileDetailsMap, required this.signController})
      : super(key: key);

  saveSign() {
    signController.onDrawEnd = () async {
      profileDetailsMap['sign'] =
          'data:image/png;base64,${base64Encode(await signController.toPngBytes() as List<int>)}';
    };
  }

  @override
  Widget build(BuildContext context) {
    saveSign();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(StringConstants.kSignature,
                style: Theme.of(context).textTheme.medium),
            IconButton(
              onPressed: () {
                signController.clear();
              },
              icon: const Icon(
                Icons.refresh,
              ),
              iconSize: kIconSize,
            )
          ],
        ),
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.lightGrey)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Signature(
              controller: signController,
              width: double.infinity,
              height: kSignaturePadHeight,
              backgroundColor: AppColor.white,
            ),
          ),
        ),
      ],
    );
  }
}
