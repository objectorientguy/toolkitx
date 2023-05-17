abstract class EditProfileEvents {}

class EditProfile extends EditProfileEvents {
  final Map editProfileDetails;

  EditProfile({required this.editProfileDetails});
}

class ValidateEditProfile extends EditProfileEvents {
  final String errorMessage;

  ValidateEditProfile({required this.errorMessage});
}
