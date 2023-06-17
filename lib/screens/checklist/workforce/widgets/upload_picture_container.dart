import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';

class UploadPictureContainer extends StatelessWidget {
  final List imagePathsList;
  final bool isImageAttached;

  const UploadPictureContainer(
      {Key? key, required this.imagePathsList, required this.isImageAttached})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 200 / 350,
            crossAxisCount: 4,
            crossAxisSpacing: tinier,
            mainAxisSpacing: tinier),
        itemCount: imagePathsList.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.cancel_outlined,
                      color: AppColor.errorRed, size: kIconSize),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AndroidPopUp(
                              titleValue: 'Delete',
                              contentValue: StringConstants.kDeleteImage,
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<PickAndUploadImageBloc>().add(
                                    PickCameraImage(
                                        isImageAttached: false,
                                        cameraImageList: imagePathsList,
                                        index: index));
                                context.read<PickAndUploadImageBloc>().add(
                                    PickGalleryImage(
                                        isImageAttached: false,
                                        galleryImagesList: imagePathsList,
                                        index: index));
                              });
                        });
                  }),
              subtitle: Image.file(File(imagePathsList[index])));
        });
  }
}
