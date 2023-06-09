import 'package:equatable/equatable.dart';

import '../../data/models/uploadPicture/upload_picture_model.dart';

abstract class UploadImageStates extends Equatable {
  const UploadImageStates();

  @override
  List<Object> get props => [];
}

class UploadImageInitial extends UploadImageStates {}

class UploadingImage extends UploadImageStates {}

class ImageUploaded extends UploadImageStates {
  final UploadPictureModel uploadPictureModel;

  const ImageUploaded({required this.uploadPictureModel});

  @override
  List<Object> get props => [uploadPictureModel];
}

class ImageNotUploaded extends UploadImageStates {
  final String imageNotUploaded;

  const ImageNotUploaded({required this.imageNotUploaded});

  @override
  List<Object> get props => [imageNotUploaded];
}
