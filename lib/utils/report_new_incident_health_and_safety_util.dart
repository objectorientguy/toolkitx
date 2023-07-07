import 'package:flutter/cupertino.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import '../configs/app_color.dart';
import '../screens/incident/widgets/incident_custom_field_info_expansion_tile.dart';

class ReportNewIncidentHealthAndSafetyUtil {
  Widget addHealthAndSafetyCaseWidget(
      index, customFieldDatum, customFieldList, addIncidentMap) {
    customFieldList.add({});
    switch (customFieldDatum[index].type) {
      case 4:
        return IncidentReportCustomFiledInfoExpansionTile(
            onCustomFieldChanged: (String customFieldOptionId) {
              customFieldList[index]['id'] =
                  customFieldDatum[index].id.toString();
              customFieldList[index]['value'] = customFieldOptionId;
            },
            index: index,
            addIncidentMap: addIncidentMap);
      case 2:
        return TextFieldWidget(
            value: (addIncidentMap['customfields'] == null ||
                    addIncidentMap['customfields'].isEmpty)
                ? ""
                : addIncidentMap['customfields'][index]['value'],
            maxLength: 250,
            onTextFieldChanged: (String textField) {
              customFieldList[index]['id'] =
                  customFieldDatum[index].id.toString();
              customFieldList[index]['value'] = textField;
            });
      default:
        return Container(
          color: AppColor.deepBlue,
        );
    }
  }
}
