import 'package:flutter/cupertino.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import '../configs/app_color.dart';
import '../screens/incident/widgets/incident_custom_field_info_expansion_tile.dart';

class ReportNewIncidentHealthAndSafetyUtil {
  Widget addHealthAndSafetyCaseWidget(
      index, customFieldDatum, customFieldList) {
    customFieldList.add({
      "id": '',
      "value": '',
    });
    switch (customFieldDatum[index].type) {
      case 4:
        return IncidentReportCustomFiledInfoExpansionTile(
          onCustomFieldChanged: (int customFieldOptionId) {
            customFieldList[index]['id'] =
                customFieldDatum[index].id.toString();
            customFieldList[index]['value'] = customFieldOptionId.toString();
          },
          index: index,
        );
      case 2:
        return TextFieldWidget(
            maxLength: 250,
            onTextFieldChanged: (String textField) {
              customFieldList[index]['id'] =
                  customFieldDatum[index].id.toString();
              customFieldList[index]['value'] = textField.toString();
            });
      default:
        return Container(
          color: AppColor.deepBlue,
        );
    }
  }
}
