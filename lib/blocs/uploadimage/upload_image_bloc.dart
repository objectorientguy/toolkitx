import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_events.dart';
import 'package:toolkit/blocs/uploadImage/upload_image_states.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/uploadImage/upload_image_model.dart';
import '../../di/app_module.dart';
import '../../repositories/uploadImage/upload_image_repository.dart';

class UploadImageBloc extends Bloc<UploadImage, UploadImageStates> {
  final UploadImageRepository _uploadPictureRepository =
      getIt<UploadImageRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  UploadImageStates get initialState => UploadImageInitial();

  UploadImageBloc() : super(UploadImageInitial()) {
    on<UploadImageEvent>(_uploadImageEvent);
  }

  FutureOr<void> _uploadImageEvent(
      UploadImageEvent event, Emitter<UploadImageStates> emit) async {
    String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
    try {
      UploadPictureModel uploadPictureModel = await _uploadPictureRepository
          .uploadImage(File(event.imageFile), hashCode);
      emit(ImageUploaded(uploadPictureModel: uploadPictureModel));
    } catch (e) {
      emit(const ImageNotUploaded(
          imageNotUploaded: 'Cannot upload image! Please try again!'));
    }
  }
}
