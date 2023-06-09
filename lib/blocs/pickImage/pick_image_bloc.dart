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
  List imagePathsList = [];

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
      add(const PickGalleryImage(isImageAttached: true, galleryImagePath: ''));
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
        log("boolll========>${event.isImageAttached}");
        log("event image list========>${event.cameraImageList}");
        log("event list length========>${event.cameraImageList.length}");
        log("index========>${event.index}");
        event.cameraImageList.removeAt(event.index!);
        // if (event.index! >= 0 && event.index! < event.cameraImageList.length) {
        //   event.cameraImageList.removeAt(event.index!);
        //   log("removee========>${event.cameraImageList.removeAt(event.index!)}");
        //   log("removee list========>${event.cameraImageList}");
        // }
        log("index after========>${event.index}");
        emit(ImagePickerLoaded(
            imagePath: File(event.cameraImageList[0]).path,
            isImageAttached: true,
            imagePathsList: event.cameraImageList));
      } else {
        final pickedFile = await _imagePicker.pickImage(
            source: ImageSource.camera, imageQuality: 25);
        if (pickedFile != null) {
          String cameraPaths = '';
          imagePathsList.add(pickedFile.path);
          for (int i = 0; i < imagePathsList.length; i++) {
            cameraPaths = imagePathsList[i];
            log("paths loop======>$cameraPaths");
          }
          emit(ImagePickerLoaded(
              imagePath: File(cameraPaths).path,
              isImageAttached: event.isImageAttached,
              imagePathsList: imagePathsList));
        } else {
          emit(const ImagePickerError(''));
        }
      }
    } catch (e) {
      emit(const ImagePickerError('Failed to capture image'));
    }
  }

  FutureOr<void> _pickGalleryImage(
      PickGalleryImage event, Emitter<PickImageStates> emit) async {
    try {
      if (event.isImageAttached == false) {
        String galleryImagePath = event.galleryImagePath;
        galleryImagePath = "null";
        emit(ImagePickerLoaded(
            imagePath: File(galleryImagePath).path,
            isImageAttached: event.isImageAttached,
            imagePathsList: []));
      } else {
        final pickedFile =
            await _imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          String cameraPaths = '';
          imagePathsList.add(pickedFile.path);
          for (int i = 0; i < imagePathsList.length; i++) {
            cameraPaths = imagePathsList[i];
            log("paths loop======>$cameraPaths");
          }
          emit(ImagePickerLoaded(
              imagePath: File(cameraPaths).path,
              isImageAttached: true,
              imagePathsList: imagePathsList));
        } else {
          emit(const ImagePickerError(''));
        }
      }
    } catch (e) {
      emit(const ImagePickerError('Failed to pick image'));
    }
  }
}
