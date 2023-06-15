import '../../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';

abstract class FetchPdfStates {}

class FetchPdfInitial extends FetchPdfStates {}

class FetchingPdf extends FetchPdfStates {}

class PdfFetched extends FetchPdfStates {
  final GetPdfModel getPdfModel;
  String decryptedFile;

  PdfFetched({required this.getPdfModel, required this.decryptedFile});
}

class FetchPdfError extends FetchPdfStates {}
