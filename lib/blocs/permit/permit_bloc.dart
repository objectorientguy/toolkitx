import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';

import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../di/app_module.dart';
import '../../repositories/permit/permit_repository.dart';

class PermitBloc extends Bloc<PermitEvents, PermitStates> {
  final PermitRepository _permitRepository = getIt<PermitRepository>();

  PermitBloc() : super(const FetchingPermitsInitial()) {
    on<GetAllPermits>(_getAllPermits);
    on<GetPermitDetails>(_getPermitDetails);
  }

  FutureOr<void> _getAllPermits(
      GetAllPermits event, Emitter<PermitStates> emit) async {
    try {
      emit(const FetchingAllPermits());
      AllPermitModel allPermitModel = await _permitRepository.getAllPermits();
      emit(AllPermitsFetched(allPermitModel: allPermitModel));
    } catch (e) {
      emit(const CouldNotFetchPermits());
      rethrow;
    }
  }

  FutureOr<void> _getPermitDetails(
      GetPermitDetails event, Emitter<PermitStates> emit) async {
    try {
      emit(const FetchingPermitDetails());
      PermitDetailsModel permitDetailsModel =
          await _permitRepository.fetchPermitDetails();
      emit(PermitDetailsFetched(permitDetailsModel: permitDetailsModel));
    } catch (e) {
      emit(const CouldNotFetchPermitDetails());
      rethrow;
    }
  }
}
