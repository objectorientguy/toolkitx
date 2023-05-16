abstract class EditProfileStates {}

class EditProfileInitial extends EditProfileStates {}

class EditProfileLoading extends EditProfileStates {}

class EditProfileLoaded extends EditProfileStates {
  final Map editProfileDetailsMap;

  EditProfileLoaded({required this.editProfileDetailsMap});
}

class EditProfileError extends EditProfileStates {
  final String message;

  EditProfileError({required this.message});
}

class EditProfileValidation extends EditProfileStates {
  final String message;

  EditProfileValidation({required this.message});
}
