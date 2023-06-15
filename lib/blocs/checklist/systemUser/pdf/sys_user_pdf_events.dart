abstract class FetchPdfEvent {}

class FetchPdf extends FetchPdfEvent {
  final String responseId;

  FetchPdf({required this.responseId});
}
