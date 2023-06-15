import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/permit_details_model.dart';

abstract class PermitStates {
  const PermitStates();
}

class FetchingPermitsInitial extends PermitStates {
  const FetchingPermitsInitial();
}

class FetchingAllPermits extends PermitStates {
  const FetchingAllPermits();
}

class AllPermitsFetched extends PermitStates {
  final AllPermitModel allPermitModel;

  const AllPermitsFetched({required this.allPermitModel});
}

class CouldNotFetchPermits extends PermitStates {
  const CouldNotFetchPermits();
}

class FetchingPermitDetails extends PermitStates {
  const FetchingPermitDetails();
}

class PermitDetailsFetched extends PermitStates {
  final PermitDetailsModel permitDetailsModel;

  const PermitDetailsFetched({required this.permitDetailsModel});
}

class CouldNotFetchPermitDetails extends PermitStates {
  const CouldNotFetchPermitDetails();
}

class GeneratingPDF extends PermitStates {
  const GeneratingPDF();
}

class PDFGenerated extends PermitStates {
  final PdfGenerationModel pdfGenerationModel;

  const PDFGenerated({required this.pdfGenerationModel});
}

class PDFGenerationFailed extends PermitStates {
  const PDFGenerationFailed();
}
