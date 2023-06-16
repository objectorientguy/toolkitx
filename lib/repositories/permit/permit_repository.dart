import 'package:toolkit/data/models/permit/permit_roles_model.dart';

import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/permit_details_model.dart';

abstract class PermitRepository {
  Future<AllPermitModel> getAllPermits(
      String hashCode, String filter, String role);

  Future<PermitRolesModel> fetchPermitRoles(String hashCode, String userId);

  Future<PermitDetailsModel> fetchPermitDetails(
      String hashCode, String permitId, String role);

  Future<PdfGenerationModel> generatePdf(String hashCode, String permitId);
}
