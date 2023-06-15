class ModulesModel {
  final String moduleName;
  final String moduleImage;
  final bool? offLineSupport;
  final String key;

  ModulesModel(
      {required this.key,
      required this.moduleName,
      required this.moduleImage,
      this.offLineSupport = false});
}
