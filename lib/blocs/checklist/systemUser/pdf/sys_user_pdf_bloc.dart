import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/pdf/sys_user_pdf_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/pdf/sys_user_pdf_states.dart';
import 'package:toolkit/data/models/encrypt_class.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class FetchPdfBloc extends Bloc<FetchPdfEvent, FetchPdfStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  FetchPdfStates get initialState => FetchPdfInitial();

  FetchPdfBloc() : super(FetchPdfInitial()) {
    on<FetchPdf>(_fetchPdf);
  }

  FutureOr<void> _fetchPdf(FetchPdf event, Emitter<FetchPdfStates> emit) async {
    emit(FetchingPdf());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String apiKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      GetPdfModel getPdfModel = await _sysUserCheckListRepository.fetchPdf(
          event.responseId, hashCode);
      var decrypted =
          EncryptData.decryptAESPrivateKey(getPdfModel.message, apiKey);
      emit(PdfFetched(getPdfModel: getPdfModel, decryptedFile: decrypted));
    } catch (e) {
      emit(FetchPdfError());
    }
  }
}
