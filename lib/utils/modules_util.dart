import '../data/models/modules_model.dart';

abstract class ModulesUtil {
  static String kBaseImagePath = 'assets/icons/';
  static List<ModulesModel> listModulesMode = [
    ModulesModel(
        moduleName: 'Log Book', moduleImage: '${kBaseImagePath}logbook.png'),
    ModulesModel(
        moduleName: 'Calendar', moduleImage: '${kBaseImagePath}calendar.png'),
    ModulesModel(
        moduleName: 'Quality Management',
        moduleImage: '${kBaseImagePath}quality_service.png'),
    ModulesModel(
        moduleName: 'Hazard', moduleImage: '${kBaseImagePath}hazard.png'),
    ModulesModel(
        moduleName: 'Permit',
        moduleImage: '${kBaseImagePath}permit.png',
        offLineSupport: true),
    ModulesModel(
        moduleName: 'Time & Vacation',
        moduleImage: '${kBaseImagePath}holiday.png'),
    ModulesModel(
        moduleName: 'Incident', moduleImage: '${kBaseImagePath}logbook.png'),
    ModulesModel(moduleName: 'ToDo', moduleImage: '${kBaseImagePath}to_do.png'),
    ModulesModel(
        moduleName: 'Safety Notice',
        moduleImage: '${kBaseImagePath}shield.png'),
    ModulesModel(
        moduleName: 'Work Order', moduleImage: '${kBaseImagePath}logbook.png'),
    ModulesModel(
        moduleName: 'Meeting Room',
        moduleImage: '${kBaseImagePath}briefing.png'),
    ModulesModel(
        moduleName: 'Certificates',
        moduleImage: '${kBaseImagePath}certificate.png'),
    ModulesModel(
        moduleName: 'Expense', moduleImage: '${kBaseImagePath}expenses.png'),
    ModulesModel(
        moduleName: 'Checklist', moduleImage: '${kBaseImagePath}checklist.png'),
    ModulesModel(
        moduleName: 'Documents', moduleImage: '${kBaseImagePath}documents.png'),
    ModulesModel(
        moduleName: 'Equipment Traceability',
        moduleImage: '${kBaseImagePath}mechanic.png'),
    ModulesModel(
        moduleName: 'LOTO', moduleImage: '${kBaseImagePath}lottery.png'),
  ];
}
