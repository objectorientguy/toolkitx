import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_picture_container.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/secondary_button.dart';
import '../../../../widgets/upload_alert_dialog.dart';

typedef UploadImageResponseCallBack = Function(List uploadImageList);

class UploadImageMenu extends StatelessWidget {
  final UploadImageResponseCallBack onUploadImageResponse;
  static List uploadImageList = [];
  static List imagesList = [];
  final void Function()? onSign;
  final void Function()? removeSignPad;
  final bool? showSignPad;
  final bool? isSignature;

  const UploadImageMenu(
      {Key? key,
      required this.onUploadImageResponse,
      this.onSign,
      this.isSignature = false,
      this.showSignPad = false,
      this.removeSignPad})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (isSignature == false)
        BlocBuilder<PickAndUploadImageBloc, PickAndUploadImageStates>(
            builder: (context, state) {
          if (state is PickImageLoading) {
            return const Padding(
              padding: EdgeInsets.all(xxTinierSpacing),
              child: SizedBox(
                  width: kProgressIndicatorTogether,
                  height: kProgressIndicatorTogether,
                  child: CircularProgressIndicator()),
            );
          } else if (state is ImagePickerLoaded) {
            uploadImageList.add(state.uploadPictureModel.data);
            onUploadImageResponse(uploadImageList);
            imagesList = List.from(state.imagePathsList);
            return (state.isImageAttached == true)
                ? UploadPictureContainer(
                    imagePathsList: state.imagePathsList,
                    isImageAttached: state.isImageAttached,
                    uploadPictureModel: state.uploadPictureModel)
                : const SizedBox();
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
                  return UploadAlertDialog(
                    isSignature: isSignature,
                    onCamera: () {
                      if (removeSignPad != null) {
                        removeSignPad!();
                      }
                      context.read<PickAndUploadImageBloc>().add(
                          PickCameraImage(
                              cameraImageList: imagesList,
                              isImageAttached: null,
                              isSignature: isSignature!));
                      Navigator.pop(context);
                    },
                    onDevice: () {
                      if (removeSignPad != null) {
                        removeSignPad!();
                      }
                      context.read<PickAndUploadImageBloc>().add(
                          PickGalleryImage(
                              isImageAttached: null,
                              galleryImagesList: imagesList,
                              isSignature: isSignature!));
                      Navigator.pop(context);
                    },
                    onSign: onSign,
                  );
                });
          },
          textValue: (isSignature == false)
              ? StringConstants.kUpload
              : StringConstants.kUploadSignature)
    ]);
  }
}
