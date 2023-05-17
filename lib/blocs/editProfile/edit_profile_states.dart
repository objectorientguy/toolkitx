abstract class EditProfileStates {}

class EditProfileInitial extends EditProfileStates {}

class EditProfileLoading extends EditProfileStates {}

class EditProfileLoaded extends EditProfileStates {
  final Map editProfileDetailsMap;

  EditProfileLoaded({required this.editProfileDetailsMap});
}

class EditProfileError extends EditProfileStates {
  final String errorMessage;

  EditProfileError({required this.errorMessage});
}

class EditProfileValidation extends EditProfileStates {
  final String validationMessage;

  EditProfileValidation({required this.validationMessage});
}
