import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';

import '../../data/models/permit/all_permits_model.dart';
import '../../di/app_module.dart';
import '../../repositories/permit/permit_repository.dart';

class PermitBloc extends Bloc<PermitEvents, PermitStates> {
  final PermitRepository _permitRepository = getIt<PermitRepository>();

  PermitBloc() : super(const FetchingAllPermits()) {
    on<GetAllPermits>(_getAllPermits);
  }

  FutureOr<void> _getAllPermits(
      GetAllPermits event, Emitter<PermitStates> emit) async {
    try {
      AllPermitModel allPermitModel = await _permitRepository.getAllPermits();
      emit(AllPermitsFetched(allPermitModel: allPermitModel));
    } catch (e) {
      emit(const CouldNotFetchPermits());
      rethrow;
    }
  }
}
