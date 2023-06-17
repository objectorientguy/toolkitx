import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_picture_container.dart';
import '../../../../blocs/pickImage/pick_image_bloc.dart';
import '../../../../blocs/pickImage/pick_image_events.dart';
import '../../../../blocs/pickImage/pick_image_states.dart';
import '../../../../blocs/uploadImage/upload_image_events.dart';
import '../../../../blocs/uploadimage/upload_image_bloc.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/secondary_button.dart';
import '../../../../widgets/upload_alert_dialog.dart';

class UploadImageSection extends StatelessWidget {
  const UploadImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BlocConsumer<PickImageBloc, PickImageStates>(listener: (context, state) {
        if (state is ImagePickerLoaded) {
          log("state image path=====>${state.imagePath}");
          (state.isImageAttached == true)
              ? context
                  .read<UploadImageBloc>()
                  .add(UploadImageEvent(imageFile: state.imagePath))
              : null;
        } else if (state is ImagePickerError) {
          showCustomSnackBar(context, state.errorMessage, '');
        }
      }, builder: (context, state) {
        log("stat builder====>$state");
        if (state is PickImageLoading) {
          return const SizedBox();
        } else if (state is ImagePickerLoaded) {
          log("listtttt state====>${state.imagePathsList}");
          log("image attached state====>${state.isImageAttached}");
          return Visibility(
              visible: state.isImageAttached == true,
              child: UploadPictureContainer(
                  imagePathsList: state.imagePathsList,
                  isImageAttached: state.isImageAttached));
        } else if (state is ImagePickerError) {
          return Text(
            state.errorMessage,
            style: const TextStyle(color: AppColor.errorRed),
          );
        } else {
          return const SizedBox();
        }
      }),
      SecondaryButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return UploadAlertDialog(onCamera: () {
                    context
                        .read<PickImageBloc>()
                        .add(RequestCameraPermission());
                    Navigator.pop(context);
                  }, onDevice: () {
                    context
                        .read<PickImageBloc>()
                        .add(RequestGalleryPermission());
                    Navigator.pop(context);
                  });
                });
          },
          textValue: StringConstants.kUpload)
    ]);
  }
}
