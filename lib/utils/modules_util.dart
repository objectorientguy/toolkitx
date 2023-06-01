import '../data/models/modules_model.dart';

abstract class ModulesUtil {
  static String kBaseImagePath = 'assets/icons/';
  static List<ModulesModel> listModulesMode = [
    ModulesModel(
        moduleName: 'LogBook',
        moduleImage: '${kBaseImagePath}logbook.png',
        key: 'sl'),
    ModulesModel(
        moduleName: 'Calendar',
        moduleImage: '${kBaseImagePath}calendar.png',
        key: 'wf_calendar'),
    ModulesModel(
        moduleName: 'Calendar',
        moduleImage: '${kBaseImagePath}calendar.png',
        key: 'calendar'),
    ModulesModel(
        moduleName: 'QualityManagement',
        moduleImage: '${kBaseImagePath}quality_service.png',
        key: 'qareport'),
    ModulesModel(
        moduleName: 'Permit',
        moduleImage: '${kBaseImagePath}permit.png',
        offLineSupport: true,
        key: 'ptw'),
    ModulesModel(
        moduleName: 'Accounting',
        moduleImage: '${kBaseImagePath}permit.png',
        offLineSupport: true,
        key: 'accounting'),
    ModulesModel(
        moduleName: 'TimeVacation',
        moduleImage: '${kBaseImagePath}holiday.png',
        key: 'timesheet'),
    ModulesModel(
        moduleName: 'TimeVacation',
        moduleImage: '${kBaseImagePath}holiday.png',
        key: 'wf_timesheet'),
    ModulesModel(
        moduleName: 'Incident',
        moduleImage: '${kBaseImagePath}logbook.png',
        key: 'hse'),
    ModulesModel(
        moduleName: 'ToDo',
        moduleImage: '${kBaseImagePath}to_do.png',
        key: 'todo'),
    ModulesModel(
        moduleName: 'SafetyNotice',
        moduleImage: '${kBaseImagePath}shield.png',
        key: ''),
    ModulesModel(
        moduleName: 'WorkOrder',
        moduleImage: '${kBaseImagePath}logbook.png',
        key: 'workorder'),
    ModulesModel(
        moduleName: 'meetingRoom',
        moduleImage: '${kBaseImagePath}briefing.png',
        key: 'meeting'),
    ModulesModel(
        moduleName: 'Certificates',
        moduleImage: '${kBaseImagePath}certificate.png',
        key: 'certificates'),
    ModulesModel(
        moduleName: 'Expense',
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'timesheet'),
    ModulesModel(
        moduleName: 'Expense',
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'wf_timesheet'),
    ModulesModel(
        moduleName: 'Checklist',
        moduleImage: '${kBaseImagePath}checklist.png',
        key: 'checklist'),
    ModulesModel(
        moduleName: 'Checklist',
        moduleImage: '${kBaseImagePath}checklist.png',
        key: 'wf_checklist'),
    ModulesModel(
        moduleName: 'Documents',
        moduleImage: '${kBaseImagePath}documents.png',
        key: 'dms'),
    ModulesModel(
        moduleName: 'EquipmentTraceability',
        moduleImage: '${kBaseImagePath}mechanic.png',
        key: 'trace'),
    ModulesModel(
        moduleName: 'LOTO',
        moduleImage: '${kBaseImagePath}lottery.png',
        key: 'loto'),
    ModulesModel(
        moduleName: 'Ticket',
        moduleImage: '${kBaseImagePath}t.png',
        key: 'tickets'),
    ModulesModel(
        moduleName: 'Assets',
        moduleImage: '${kBaseImagePath}t.png',
        key: 'eam'),
    ModulesModel(
        moduleName: 'Location',
        moduleImage: '${kBaseImagePath}t.png',
        key: 'eam'),
    ModulesModel(
        moduleName: 'Trips', moduleImage: '${kBaseImagePath}t.png', key: 'hf'),
    ModulesModel(
        moduleName: 'Trips',
        moduleImage: '${kBaseImagePath}t.png',
        key: 'wf_trips'),
  ];
}
