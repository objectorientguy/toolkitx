import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pick_image_events.dart';
import 'pick_image_states.dart';

class PickImageBloc extends Bloc<PickImage, PickImageStates> {
  final ImagePicker _imagePicker = ImagePicker();
  List cameraPathsList = [];
  List galleryPathsList = [];

  PickImageStates get initialState => PermissionInitial();

  PickImageBloc() : super(PermissionInitial()) {
    on<RequestCameraPermission>(_requestCameraPermission);
    on<RequestGalleryPermission>(_requestGalleryPermission);
    on<PickCameraImage>(_pickCameraImage);
    on<PickGalleryImage>(_pickGalleryImage);
  }

  _requestCameraPermission(
      RequestCameraPermission event, Emitter<PickImageStates> emit) async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      add(const PickCameraImage(isImageAttached: true, cameraImageList: []));
    } else if (status.isDenied) {
      openAppSettings();
    } else {
      openAppSettings();
    }
  }

  _requestGalleryPermission(
      RequestGalleryPermission event, Emitter<PickImageStates> emit) async {
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
      PickCameraImage event, Emitter<PickImageStates> emit) async {
    emit(PickImageLoading());
    try {
      if (event.isImageAttached == false) {
        log("lenghtt=====>${event.cameraImageList}");
        log("index=====>${event.index}");
        if (event.index! >= 0 && event.index! < event.cameraImageList.length) {
          event.cameraImageList.removeAt(event.index!);
        }
        emit(ImagePickerLoaded(
            isImageAttached: true, imagePathsList: event.cameraImageList));
      } else {
        final pickedFile = await _imagePicker.pickImage(
            source: ImageSource.camera, imageQuality: 25);
        if (pickedFile != null) {
          cameraPathsList.add(pickedFile.path);
          emit(ImagePickerLoaded(
              isImageAttached: event.isImageAttached,
              imagePathsList: cameraPathsList));
        } else {
          emit(const ImagePickerError('hjjhjkhj'));
        }
      }
    } catch (e) {
      emit(const ImagePickerError('Failed to capture image'));
    }
  }

  FutureOr<void> _pickGalleryImage(
      PickGalleryImage event, Emitter<PickImageStates> emit) async {
    emit(PickImageLoading());
    try {
      if (event.isImageAttached == false) {
        log("lenghtt=====>${event.galleryImagesList.length}");
        log("index=====>${event.index}");
        if (event.index! >= 0 &&
            event.index! < event.galleryImagesList.length) {
          event.galleryImagesList.removeAt(event.index!);
        }
        emit(ImagePickerLoaded(
            isImageAttached: true, imagePathsList: event.galleryImagesList));
      } else {
        final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          galleryPathsList.add(pickedFile.path);
          emit(ImagePickerLoaded(
              isImageAttached: event.isImageAttached,
              imagePathsList: galleryPathsList));
        } else {
          emit(const ImagePickerError('gallery error'));
        }
      }
    } catch (e) {
      emit(const ImagePickerError('Failed to pick image'));
    }
  }
}
