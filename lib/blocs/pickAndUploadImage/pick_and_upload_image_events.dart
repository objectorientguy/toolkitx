import 'package:equatable/equatable.dart';

abstract class PickAndUploadImage extends Equatable {
  const PickAndUploadImage();

  @override
  List<Object> get props => [];
}

class RequestCameraPermission extends PickAndUploadImage {}

class RequestGalleryPermission extends PickAndUploadImage {}

class PickCameraImage extends PickAndUploadImage {
  final bool isImageAttached;
  final List cameraImageList;
  final int? index;

  const PickCameraImage(
      {this.index,
      required this.cameraImageList,
      required this.isImageAttached});
}

class PickGalleryImage extends PickAndUploadImage {
  final bool isImageAttached;
  final List galleryImagesList;

  final int? index;

  const PickGalleryImage({
    this.index,
    required this.isImageAttached,
    required this.galleryImagesList,
  });
}

class UploadImageEvent extends PickAndUploadImage {
  final String imageFile;
  final bool isImageAttached;

  const UploadImageEvent(
      {required this.isImageAttached, required this.imageFile});
}
