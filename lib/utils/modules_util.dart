import 'package:toolkit/utils/database_utils.dart';

import '../data/models/modules_model.dart';

abstract class ModulesUtil {
  static String kBaseImagePath = 'assets/icons/';
  static List<ModulesModel> listModulesMode = [
    ModulesModel(
        moduleName: DatabaseUtil.box.get('LogBook'),
        moduleImage: '${kBaseImagePath}logbook.png',
        key: 'sl'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Calendar'),
        moduleImage: '${kBaseImagePath}calendar.png',
        key: 'wf_calendar'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Calendar'),
        moduleImage: '${kBaseImagePath}calendar.png',
        key: 'calendar'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('QualityManagement'),
        moduleImage: '${kBaseImagePath}quality_service.png',
        key: 'qareport'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Permit'),
        moduleImage: '${kBaseImagePath}permit.png',
        offLineSupport: true,
        key: 'ptw'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Accounting'),
        moduleImage: '${kBaseImagePath}permit.png',
        offLineSupport: true,
        key: 'accounting'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('TimeVacation'),
        moduleImage: '${kBaseImagePath}holiday.png',
        key: 'timesheet'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('TimeVacation'),
        moduleImage: '${kBaseImagePath}holiday.png',
        key: 'wf_timesheet'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Incident'),
        moduleImage: '${kBaseImagePath}logbook.png',
        key: 'hse'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('ToDo'),
        moduleImage: '${kBaseImagePath}to_do.png',
        key: 'todo'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('SafetyNotice'),
        moduleImage: '${kBaseImagePath}shield.png',
        key: ''),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('WorkOrder'),
        moduleImage: '${kBaseImagePath}logbook.png',
        key: 'workorder'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('meetingRoom'),
        moduleImage: '${kBaseImagePath}briefing.png',
        key: 'meeting'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Certificates'),
        moduleImage: '${kBaseImagePath}certificate.png',
        key: 'certificates'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Expense'),
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'timesheet'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Expense'),
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'wf_timesheet'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Checklist'),
        moduleImage: '${kBaseImagePath}checklist.png',
        key: 'checklist'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Checklist'),
        moduleImage: '${kBaseImagePath}checklist.png',
        key: 'wf_checklist'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Documents'),
        moduleImage: '${kBaseImagePath}documents.png',
        key: 'dms'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('EquipmentTraceability'),
        moduleImage: '${kBaseImagePath}mechanic.png',
        key: 'trace'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('LOTO'),
        moduleImage: '${kBaseImagePath}lottery.png',
        key: 'loto'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Ticket'),
        moduleImage: '${kBaseImagePath}t.png',
        key: 'tickets'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Assets'),
        moduleImage: '${kBaseImagePath}t.png',
        key: 'eam'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Location'),
        moduleImage: '${kBaseImagePath}t.png',
        key: 'eam'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Trips'),
        moduleImage: '${kBaseImagePath}t.png',
        key: 'hf'),
    ModulesModel(
        moduleName: DatabaseUtil.box.get('Trips'),
        moduleImage: '${kBaseImagePath}t.png',
        key: 'wf_trips'),
  ];
}
