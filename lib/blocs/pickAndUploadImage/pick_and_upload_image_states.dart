import 'package:equatable/equatable.dart';

import '../../data/models/uploadImage/upload_image_model.dart';

abstract class PickAndUploadImageStates extends Equatable {
  const PickAndUploadImageStates();

  @override
  List<Object> get props => [];
}

class PermissionInitial extends PickAndUploadImageStates {}

class PickImageLoading extends PickAndUploadImageStates {}

class ImagePickerLoaded extends PickAndUploadImageStates {
  final UploadPictureModel uploadPictureModel;
  final bool isImageAttached;
  final List imagePathsList;
  final String imagePath;

  const ImagePickerLoaded(
      {required this.uploadPictureModel,
      required this.imagePath,
      required this.imagePathsList,
      required this.isImageAttached});

  @override
  List<Object> get props => [isImageAttached, imagePathsList, imagePath];
}

class ImagePickerError extends PickAndUploadImageStates {
  final String errorMessage;

  const ImagePickerError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ImageNotUploaded extends PickAndUploadImageStates {
  final String imageNotUploaded;

  const ImageNotUploaded({required this.imageNotUploaded});

  @override
  List<Object> get props => [imageNotUploaded];
}

class RemovePickedImage extends PickAndUploadImageStates {
  final bool isImageAttached;
  final List imagePathsList;
  final String imagePath;

  const RemovePickedImage(
      {required this.isImageAttached,
      required this.imagePathsList,
      required this.imagePath});

  @override
  List<Object> get props => [isImageAttached, imagePathsList, imagePath];
}
