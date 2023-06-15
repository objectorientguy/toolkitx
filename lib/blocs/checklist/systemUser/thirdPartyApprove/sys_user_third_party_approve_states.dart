import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';

abstract class ThirdPartyApproveStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ThirdPartyApproveInitial extends ThirdPartyApproveStates {}

class ThirdPartyApproving extends ThirdPartyApproveStates {}

class ThirdPartyApproved extends ThirdPartyApproveStates {
  final SaveThirdPartyApproval saveThirdPartyApproval;

  ThirdPartyApproved({required this.saveThirdPartyApproval});

  @override
  List<Object?> get props => [saveThirdPartyApproval];
}

class ThirdPartyNotApproved extends ThirdPartyApproveStates {
  final String errorMessage;

  ThirdPartyNotApproved({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
