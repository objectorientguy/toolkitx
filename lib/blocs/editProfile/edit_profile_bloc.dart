// ignore_for_file: unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants/string_constants.dart';
import 'edit_profile_events.dart';
import 'edit_profile_states.dart';

class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileStates> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfile>(_editProfile);
    on<ValidateEditProfile>(_validateEditProfile);
  }

  _editProfile(EditProfile event, Emitter<EditProfileStates> emit) {
    emit(EditProfileLoading());
    try {
      Map editProfileDetailsMap = {
        "firstName": event.editProfileDetails['firstName'],
        "lastName": event.editProfileDetails['lastName'],
        "contact": event.editProfileDetails['contact'],
      };
      if (event.editProfileDetails['firstName'].toString().trim() == "null" ||
          event.editProfileDetails['firstName'].toString().isEmpty) {
        add(ValidateEditProfile(message: StringConstants.kFirstNameValidate));
      } else if (event.editProfileDetails['lastName'].toString().trim() ==
              "null" ||
          event.editProfileDetails['lastName'].toString().isEmpty) {
        add(ValidateEditProfile(message: StringConstants.kLastNameValidate));
      } else if (event.editProfileDetails['contact'].toString().trim() ==
              "null" ||
          event.editProfileDetails['contact'].toString().isEmpty) {
        add(ValidateEditProfile(message: StringConstants.kContactValidate));
      } else {
        emit(EditProfileLoaded());
      }
    } catch (e) {
      emit(EditProfileError(message: e.toString()));
    }
  }

  _validateEditProfile(
      ValidateEditProfile event, Emitter<EditProfileStates> emit) {
    emit(EditProfileValidation(message: event.message));
  }
}
