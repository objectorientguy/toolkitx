import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/uploadImage/upload_image_model.dart';
import '../../di/app_module.dart';
import '../../repositories/uploadImage/upload_image_repository.dart';
import 'pick_and_upload_image_events.dart';
import 'pick_and_upload_image_states.dart';

class PickAndUploadImageBloc
    extends Bloc<PickAndUploadImage, PickAndUploadImageStates> {
  final UploadImageRepository _uploadPictureRepository =
      getIt<UploadImageRepository>();
  final ImagePicker _imagePicker = ImagePicker();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List imagePathsList = [];
  String imagePath = '';

  PickAndUploadImageStates get initialState => PermissionInitial();

  PickAndUploadImageBloc() : super(PermissionInitial()) {
    on<RequestCameraPermission>(_requestCameraPermission);
    on<RequestGalleryPermission>(_requestGalleryPermission);
    on<PickCameraImage>(_pickCameraImage);
    on<PickGalleryImage>(_pickGalleryImage);
    on<UploadImageEvent>(_uploadImageEvent);
  }

  _requestCameraPermission(RequestCameraPermission event,
      Emitter<PickAndUploadImageStates> emit) async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      add(const PickCameraImage(isImageAttached: true, cameraImageList: []));
    } else if (status.isDenied) {
      openAppSettings();
    } else {
      openAppSettings();
    }
  }

  _requestGalleryPermission(RequestGalleryPermission event,
      Emitter<PickAndUploadImageStates> emit) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      add(const PickGalleryImage(isImageAttached: true, galleryImagesList: []));
    } else if (status.isDenied) {
      openAppSettings();
    } else {
      openAppSettings();
    }
  }

  FutureOr<void> _pickCameraImage(
      PickCameraImage event, Emitter<PickAndUploadImageStates> emit) async {
    try {
      if (event.isImageAttached == false) {
        if (event.index! >= 0 && event.index! < event.cameraImageList.length) {
          event.cameraImageList.remove(event.index!);
        }
        emit(RemovePickedImage(
            isImageAttached: true,
            imagePathsList: event.cameraImageList,
            imagePath: imagePath));
      } else {
        final pickedFile = await _imagePicker.pickImage(
            source: ImageSource.camera, imageQuality: 25);
        emit(PickImageLoading());
        if (pickedFile != null) {
          imagePathsList.add(pickedFile.path);
          for (int i = 0; i < imagePathsList.length; i++) {
            imagePath = imagePathsList[i];
          }
          (event.isImageAttached == true)
              ? add(UploadImageEvent(
                  imageFile: imagePath, isImageAttached: event.isImageAttached))
              : null;
        }
      }
    } catch (e) {
      emit(const ImagePickerError('Failed to capture image'));
    }
  }

  FutureOr<void> _pickGalleryImage(
      PickGalleryImage event, Emitter<PickAndUploadImageStates> emit) async {
    emit(PickImageLoading());
    try {
      if (event.isImageAttached == false) {
        if (event.index! >= 0 &&
            event.index! < event.galleryImagesList.length) {
          event.galleryImagesList.removeAt(event.index!);
        }
        emit(RemovePickedImage(
            isImageAttached: true,
            imagePathsList: event.galleryImagesList,
            imagePath: imagePath));
      } else {
        final pickedFile =
            await _imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          imagePathsList.add(pickedFile.path);
          for (int i = 0; i < imagePathsList.length; i++) {
            imagePath = imagePathsList[i];
          }
          (event.isImageAttached == true)
              ? add(UploadImageEvent(
                  imageFile: imagePath, isImageAttached: event.isImageAttached))
              : null;
        }
      }
    } catch (e) {
      emit(const ImagePickerError('Failed to pick image'));
    }
  }

  FutureOr<void> _uploadImageEvent(
      UploadImageEvent event, Emitter<PickAndUploadImageStates> emit) async {
    String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
    try {
      UploadPictureModel uploadPictureModel = await _uploadPictureRepository
          .uploadImage(File(event.imageFile), hashCode);
      emit(ImagePickerLoaded(
          isImageAttached: event.isImageAttached,
          imagePathsList: imagePathsList,
          imagePath: imagePath,
          uploadPictureModel: uploadPictureModel));
    } catch (e) {
      emit(const ImageNotUploaded(
          imageNotUploaded: 'Cannot upload image! Please try again!'));
    }
  }
}
