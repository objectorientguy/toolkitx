import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/profile/profile_events.dart';
import 'package:toolkit/blocs/profile/profile_states.dart';
import 'package:toolkit/data/enums/user_type_emun.dart';
import 'package:toolkit/data/models/encrypt_class.dart';
import 'package:toolkit/data/models/profile/change_password_model.dart';
import 'package:toolkit/data/models/profile/generate_change_password_opt_model.dart';
import 'package:toolkit/data/models/profile/user_profile_model.dart';
import 'package:toolkit/repositories/profile/profile_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/profile/update_user_profile_model.dart';
import '../../di/app_module.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  final ProfileRepository _profileRepository = getIt<ProfileRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  ProfileStates get initialState => ProfileInitial();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserProfile>(_fetchUserProfile);
    on<UpdateProfile>(_updateProfile);
    on<DecryptUserProfileData>(_decryptUserProfileData);
    on<InitializeEditUserProfile>(_initializeEditUserProfile);
    on<ChangePasswordType>(_changePasswordType);
    on<GenerateChangePasswordOtp>(_generateChangePasswordOtp);
    on<ChangePassword>(_changePassword);
    on<CheckChangePasswordType>(_checkChangePasswordType);
    on<Logout>(_logOut);
  }

  FutureOr<void> _fetchUserProfile(
      FetchUserProfile event, Emitter<ProfileStates> emit) async {
    emit(UserProfileFetching());
    try {
      String typeValue =
          (await _customerCache.getUserType(CacheKeys.userType))!;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;

      String userType = UserType.values
          .elementAt(UserType.values
              .indexWhere((element) => element.value == typeValue))
          .type;
      UserProfileModel userProfileModel =
          await _profileRepository.fetchUserProfile(hashCode);
      emit(UserProfileFetched(
        userProfileModel: userProfileModel,
        userType: userType,
      ));
    } catch (e) {
      emit(UserProfileFetchError());
    }
  }

  FutureOr<void> _updateProfile(
      UpdateProfile event, Emitter<ProfileStates> emit) async {
    emit(UserProfileUpdating());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String contactEncrypt = '';
      String bloodGroupEncrypt = '';
      String privateKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      if (event.updateProfileMap['bloodgrp'] != '') {
        bloodGroupEncrypt = EncryptData.encryptAESPrivateKey(
            event.updateProfileMap['bloodgrp'], privateKey);
      }
      if (event.updateProfileMap['contact'] != '') {
        contactEncrypt = await EncryptData.encryptAESPrivateKey(
            event.updateProfileMap['contact'].trim(), privateKey);
      }
      Map updateUserProfileMap = {
        'hashcode': hashCode,
        'fname': event.updateProfileMap['fname'].trim(),
        'lname': event.updateProfileMap['lname'].trim(),
        'contact': contactEncrypt,
        'contact2': event.updateProfileMap['contact2'].trim(),
        'bloodgrp': bloodGroupEncrypt,
        'sign': event.updateProfileMap['sign'].trim()
      };
      UpdateUserProfileModel updateUserProfileModel =
          await _profileRepository.updateUserProfile(updateUserProfileMap);
      emit(UserProfileUpdated(updateUserProfileModel: updateUserProfileModel));
    } catch (e) {
      emit(UserProfileUpdateError());
    }
  }

  FutureOr<void> _decryptUserProfileData(
      DecryptUserProfileData event, Emitter<ProfileStates> emit) async {
    Map encryptedDataMap = event.userprofileDetails;
    String bloodGroupDecrypt = '';
    String contactDecrypt = '';
    String privateKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
    if (event.userprofileDetails['bloodgrp'].toString() != '') {
      bloodGroupDecrypt = await EncryptData.decryptAESPrivateKey(
          event.userprofileDetails['bloodgrp'], privateKey);
    } else if (event.userprofileDetails['contact'].toString() != '') {
      contactDecrypt = await EncryptData.decryptAESPrivateKey(
          event.userprofileDetails['contact'], privateKey);
    }
    encryptedDataMap['bloodgrp'] = bloodGroupDecrypt;
    encryptedDataMap['contact'] = contactDecrypt;
    add(InitializeEditUserProfile(profileDetailsMap: encryptedDataMap));
  }

  FutureOr<void> _initializeEditUserProfile(
      InitializeEditUserProfile event, Emitter<ProfileStates> emit) async {
    emit(EditProfileInitialized(profileDetailsMap: event.profileDetailsMap));
  }

  _changePasswordType(ChangePasswordType event, Emitter<ProfileStates> emit) {
    emit(
        ChangePasswordTypeLoaded(changePasswordType: event.changePasswordType));
  }

  _checkChangePasswordType(
      CheckChangePasswordType event, Emitter<ProfileStates> emit) {
    emit(ChangePasswordTypeChecked(changePasswordOtp: event.changePasswordOtp));
  }

  FutureOr<void> _generateChangePasswordOtp(
      GenerateChangePasswordOtp event, Emitter<ProfileStates> emit) async {
    emit(GeneratingChangePasswordOtp());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      Map generateOtpMap = {"hashcode": hashCode, "userid": userId};
      GenerateChangePasswordOtpModel generateChangePasswordOtpModel =
          await _profileRepository.generateOtp(generateOtpMap);
      emit(ChangePasswordOtpGenerated(
          generateChangePasswordOtpModel: generateChangePasswordOtpModel));
    } catch (e) {
      emit(ChangePasswordOtpError());
    }
  }

  FutureOr<void> _changePassword(
      ChangePassword event, Emitter<ProfileStates> emit) async {
    emit(PasswordChanging());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String privateKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;

      if (event.changePasswordMap['oldPass_opt'].toString().trim() == 'null') {
        emit(ChangePasswordError(message: 'Please enter old password/opt'));
      } else if (event.changePasswordMap['newPassword'].toString().trim() ==
          'null') {
        emit(ChangePasswordError(message: 'Please enter a new password'));
      } else if (event.changePasswordMap['confirmPassword'].toString().trim() ==
          'null') {
        emit(ChangePasswordError(message: 'Please enter confirm password'));
      } else if (event.changePasswordMap['newPassword'].toString().trim() !=
          event.changePasswordMap['confirmPassword'].toString().trim()) {
        emit(ChangePasswordError(message: 'Passwords must match, '));
      } else {
        String newPassword = await EncryptData.encryptAESPrivateKey(
            event.changePasswordMap['newPassword'].toString().trim(),
            privateKey);
        String oldPassword = await EncryptData.encryptAESPrivateKey(
            event.changePasswordMap['oldPass_opt'], privateKey);
        Map changePasswordMap = {
          "hashcode": hashCode,
          "newpassword": newPassword,
          "oldpassword": oldPassword,
          "userid": userId
        };
        ChangePasswordModel changePasswordModel =
            await _profileRepository.changePassword(changePasswordMap);
        if (changePasswordModel.status == 200) {
          emit(PasswordChanged(changePasswordModel: changePasswordModel));
        } else {
          emit(ChangePasswordError(message: changePasswordModel.message!));
        }
      }
    } catch (e) {
      emit(ChangePasswordError(message: e.toString()));
    }
  }

  FutureOr<void> _logOut(Logout event, Emitter<ProfileStates> emit) {
    _customerCache.clearAll();
    emit(LoggedOut());
  }
}
