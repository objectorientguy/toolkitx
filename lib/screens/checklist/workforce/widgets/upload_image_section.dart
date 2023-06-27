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

  const UploadImageMenu({Key? key, required this.onUploadImageResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  return UploadAlertDialog(onCamera: () {
                    context.read<PickAndUploadImageBloc>().add(PickCameraImage(
                        cameraImageList: imagesList, isImageAttached: null));
                    Navigator.pop(context);
                  }, onDevice: () {
                    context.read<PickAndUploadImageBloc>().add(PickGalleryImage(
                        isImageAttached: null, galleryImagesList: imagesList));
                    Navigator.pop(context);
                  });
                });
          },
          textValue: StringConstants.kUpload)
    ]);
  }
}
