import 'dart:developer';
import 'dart:io';

import 'package:toolkit/data/models/uploadPicture/upload_picture_model.dart';
import 'package:toolkit/repositories/uploadPicture/upload_picture_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class UploadImageRepositoryImpl extends UploadImageRepository {
  @override
  Future<UploadPictureModel> uploadImage(
      Map uploadPictureMap, File imageFile) async {
    final response = await DioClient().multiPart(
        "${ApiConstants.baseUrl}commonfileupload/upload",
        uploadPictureMap,
        imageFile);
    log("headerr upload picture========>$response");
    return UploadPictureModel.fromJson(response);
  }
}
