import 'package:flutter/cupertino.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import '../configs/app_color.dart';
import '../screens/incident/widgets/incident_custom_field_info_expansion_tile.dart';

class ReportNewIncidentHealthAndSafetyUtil {
  Widget addHealthAndSafetyCaseWidget(
      index, customFieldDatum, customFieldList) {
    customFieldList.add({
      "id": customFieldDatum[index].id,
      "value": '',
    });
    switch (customFieldDatum[index].type) {
      case 4:
        return IncidentReportCustomFiledInfoExpansionTile(
          onCustomFieldChanged: (String customFieldOptionId) {
            customFieldList[index]['value'] = customFieldOptionId;
          },
          index: index,
        );
      case 2:
        return TextFieldWidget(
            maxLength: 250,
            onTextFieldChanged: (String textField) {
              customFieldList[index]['value'] = textField;
            });
      default:
        return Container(
          color: AppColor.deepBlue,
        );
    }
  }
}
