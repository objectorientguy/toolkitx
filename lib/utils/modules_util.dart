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
        moduleImage: '${kBaseImagePath}incident.png',
        key: 'hse'),
    ModulesModel(
        moduleName: 'ToDo',
        moduleImage: '${kBaseImagePath}to_do.png',
        key: 'todo'),
    ModulesModel(
        moduleName: 'SafetyNotice',
        moduleImage: '${kBaseImagePath}shield.png',
        key: 'safetyNotice'),
    ModulesModel(
        moduleName: 'WorkOrder',
        moduleImage: '${kBaseImagePath}workOrder.png',
        key: 'workorder'),
    ModulesModel(
        moduleName: 'meetingRoom',
        moduleImage: '${kBaseImagePath}briefing.png',
        key: 'meeting'),
    ModulesModel(
        moduleName: 'Assets',
        moduleImage: '${kBaseImagePath}assets.png',
        key: 'eam'),
    ModulesModel(
        moduleName: 'Expense',
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'timesheet'),
    ModulesModel(
        moduleName: 'Expense',
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'wf_timesheet'),
    ModulesModel(
        moduleName: 'Certificates',
        moduleImage: '${kBaseImagePath}certificate.png',
        key: 'certificates'),
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
        moduleImage: '${kBaseImagePath}ticket.png',
        key: 'tickets'),
    ModulesModel(
        moduleName: 'Trips',
        moduleImage: '${kBaseImagePath}trips.png',
        key: 'hf'),
    ModulesModel(
        moduleName: 'Trips',
        moduleImage: '${kBaseImagePath}trips.png',
        key: 'wf_trips'),
  ];
}
