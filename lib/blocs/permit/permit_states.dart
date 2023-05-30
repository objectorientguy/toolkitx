import '../../data/models/permit/all_permits_model.dart';

abstract class PermitStates {
  const PermitStates();
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
