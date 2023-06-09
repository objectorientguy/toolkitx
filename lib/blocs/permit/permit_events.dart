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
