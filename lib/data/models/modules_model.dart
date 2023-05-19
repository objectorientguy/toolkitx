class ModulesModel {
  final String moduleName;
  final String moduleImage;
  final bool? offLineSupport;

  ModulesModel(
      {required this.moduleName,
      required this.moduleImage,
      this.offLineSupport = false});
}
