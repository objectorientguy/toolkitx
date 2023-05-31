import 'package:toolkit/data/models/profile/change_password_model.dart';
import 'package:toolkit/data/models/profile/update_user_profile_model.dart';
import 'package:toolkit/data/models/profile/user_profile_model.dart';

import '../../data/models/profile/generate_change_password_opt_model.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class UserProfileFetching extends ProfileStates {}

class UserProfileFetched extends ProfileStates {
  final UserProfileModel userProfileModel;
  final String userType;
  final String dateTimeValue;

  UserProfileFetched(
      {required this.userType,
      required this.userProfileModel,
      required this.dateTimeValue});
}

class UserProfileFetchError extends ProfileStates {}

class UserProfileUpdating extends ProfileStates {}

class UserProfileUpdated extends ProfileStates {
  final UpdateUserProfileModel updateUserProfileModel;

  UserProfileUpdated({required this.updateUserProfileModel});
}

class UserProfileUpdateError extends ProfileStates {
  final String message;

  UserProfileUpdateError({this.message = ''});
}

class EditProfileInitialized extends ProfileStates {
  final Map profileDetailsMap;

  EditProfileInitialized({required this.profileDetailsMap});
}

class ChangePasswordTypeLoaded extends ProfileStates {
  final String changePasswordType;

  ChangePasswordTypeLoaded({required this.changePasswordType});
}

class GeneratingChangePasswordOtp extends ProfileStates {}

class ChangePasswordOtpGenerated extends ProfileStates {
  final GenerateChangePasswordOtpModel generateChangePasswordOtpModel;

  ChangePasswordOtpGenerated({required this.generateChangePasswordOtpModel});
}

class ChangePasswordOtpError extends ProfileStates {
  final String message;

  ChangePasswordOtpError({this.message = ''});
}

class PasswordChanging extends ProfileStates {}

class PasswordChanged extends ProfileStates {
  final ChangePasswordModel changePasswordModel;

  PasswordChanged({required this.changePasswordModel});
}

class ChangePasswordError extends ProfileStates {
  final String message;

  ChangePasswordError({this.message = ''});
}

class ChangePasswordTypeChecked extends ProfileStates {
  final bool changePasswordOtp;

  ChangePasswordTypeChecked({required this.changePasswordOtp});
}

class LoggedOut extends ProfileStates {}
