abstract class PermitEvents {
  const PermitEvents();
}

class GetAllPermits extends PermitEvents {
  const GetAllPermits();
}

class GetPermitDetails extends PermitEvents {
  const GetPermitDetails();
}

class GeneratePDF extends PermitEvents {
  const GeneratePDF();
}

class GetPermitRoles extends PermitEvents {
  const GetPermitRoles();
}

class SelectPermitRoleEvent extends PermitEvents {
  final String roleId;

  const SelectPermitRoleEvent(this.roleId);
}
