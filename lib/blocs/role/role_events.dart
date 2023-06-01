import '../../../data/models/permit/permit_roles_model.dart';

abstract class PermitRoleEvents {
  const PermitRoleEvents();
}

class GetPermitRoles extends PermitRoleEvents {
  const GetPermitRoles();
}

class SelectCheckBoxEvent extends PermitRoleEvents {
  final Datum selectedDatum;

  const SelectCheckBoxEvent(this.selectedDatum);
}
