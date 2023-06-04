import 'package:toolkit/data/models/permit/permit_roles_model.dart';

import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/permit_details_model.dart';

abstract class PermitRepository {
  Future<AllPermitModel> getAllPermits();

  Future<PermitRolesModel> fetchPermitRoles();

  Future<PermitDetailsModel> fetchPermitDetails();

  Future<PdfGenerationModel> generatePdf();
}
