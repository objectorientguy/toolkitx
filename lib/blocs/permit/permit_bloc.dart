import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_roles_model.dart';
import '../../di/app_module.dart';
import '../../repositories/permit/permit_repository.dart';

class PermitBloc extends Bloc<PermitEvents, PermitStates> {
  final PermitRepository _permitRepository = getIt<PermitRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = 'XyXKlqi+qAnXdhxREzo0SQ==';
  Datum? selectedDatum;

  PermitBloc() : super(const FetchingPermitsInitial()) {
    on<GetAllPermits>(_getAllPermits);
    on<GetPermitDetails>(_getPermitDetails);
    on<GeneratePDF>(_generatePDF);
    on<GetPermitRoles>(_fetchPermitRoles);
    on<SelectPermitRoleEvent>(_selectPermitRoleEvent);
  }

  FutureOr<void> _selectPermitRoleEvent(
      SelectPermitRoleEvent event, Emitter<PermitStates> emit) async {
    roleId = event.roleId;
    emit(PermitRoleSelected());
  }

  FutureOr<void> _fetchPermitRoles(
      GetPermitRoles event, Emitter<PermitStates> emit) async {
    try {
      emit(const FetchingPermitRoles());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      PermitRolesModel permitRolesModel =
          await _permitRepository.fetchPermitRoles(hashCode, userId);
      roleId = ((roleId == '') ? permitRolesModel.data![0].groupId : roleId)!;
      emit(PermitRolesFetched(
          permitRolesModel: permitRolesModel, roleId: roleId));
    } catch (e) {
      emit(const CouldNotFetchPermitRoles());
      rethrow;
    }
  }

  FutureOr<void> _getAllPermits(
      GetAllPermits event, Emitter<PermitStates> emit) async {
    try {
      emit(const FetchingAllPermits());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      AllPermitModel allPermitModel =
          await _permitRepository.getAllPermits(hashCode, '', roleId);
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
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      PermitDetailsModel permitDetailsModel =
          await _permitRepository.fetchPermitDetails(hashCode, '', '');
      emit(PermitDetailsFetched(permitDetailsModel: permitDetailsModel));
    } catch (e) {
      emit(const CouldNotFetchPermitDetails());
      rethrow;
    }
  }

  FutureOr<void> _generatePDF(
      GeneratePDF event, Emitter<PermitStates> emit) async {
    try {
      emit(const GeneratingPDF());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      final PdfGenerationModel pdfGenerationModel =
          await _permitRepository.generatePdf(hashCode, '');
      emit(PDFGenerated(pdfGenerationModel: pdfGenerationModel));
    } catch (e) {
      emit(const CouldNotFetchPermits());
      rethrow;
    }
  }
}
