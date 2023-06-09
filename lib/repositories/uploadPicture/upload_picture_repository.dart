import 'dart:io';

import 'package:toolkit/data/models/uploadPicture/upload_picture_model.dart';

abstract class UploadImageRepository {
  Future<UploadPictureModel> uploadImage(Map uploadPictureMap, File imageFile);
}
