import 'package:equatable/equatable.dart';

abstract class UploadImage extends Equatable {
  const UploadImage();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends UploadImage {
  final String imageFile;

  const UploadImageEvent({required this.imageFile});
}
