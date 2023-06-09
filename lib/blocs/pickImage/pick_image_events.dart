import 'package:equatable/equatable.dart';

abstract class PickImage extends Equatable {
  const PickImage();

  @override
  List<Object> get props => [];
}

class RequestCameraPermission extends PickImage {}

class RequestGalleryPermission extends PickImage {}

class PickCameraImage extends PickImage {
  final bool isImageAttached;
  final List cameraImageList;
  final int? index;

  const PickCameraImage(
      {this.index,
      required this.cameraImageList,
      required this.isImageAttached});
}

class PickGalleryImage extends PickImage {
  final String galleryImagePath;
  final bool isImageAttached;

  const PickGalleryImage(
      {required this.galleryImagePath, required this.isImageAttached});
}
