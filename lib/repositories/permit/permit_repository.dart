import '../../data/models/permit/all_permits_model.dart';

abstract class PermitRepository {
  Future<AllPermitModel> getAllPermits();
}
