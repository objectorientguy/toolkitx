import 'package:equatable/equatable.dart';

abstract class PickImageStates extends Equatable {
  const PickImageStates();

  @override
  List<Object> get props => [];
}

class PermissionInitial extends PickImageStates {}

class PickImageLoading extends PickImageStates {}

class ImagePickerLoaded extends PickImageStates {
  final String imagePath;
  final bool isImageAttached;
  final List imagePathsList;
  final int? index;

  const ImagePickerLoaded(
      {this.index,
      required this.imagePathsList,
      required this.isImageAttached,
      required this.imagePath});

  @override
  List<Object> get props =>
      [imagePathsList, imagePath, isImageAttached, index!];
}

class ImagePickerError extends PickImageStates {
  final String errorMessage;

  const ImagePickerError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
