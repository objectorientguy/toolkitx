import '../data/models/incident/fetch_incident_master_model.dart';

class IncidentSelectCategoryUtil {
  static selectCategory(FetchIncidentMasterModel fetchIncidentMasterModel,
      int index, int itemIndex, bool isSelected, List selectedItemsList) {
    List showCategory = [];
    showCategory = [
      {
        'title': fetchIncidentMasterModel.data[2][0].typename,
        'items': [
          for (int i = 0; i < fetchIncidentMasterModel.data[2].length; i++)
            fetchIncidentMasterModel.data[2][i].name
        ]
      },
      {
        'title': fetchIncidentMasterModel.data[3][0].typename,
        'items': [
          for (int i = 0; i < fetchIncidentMasterModel.data[3].length; i++)
            fetchIncidentMasterModel.data[3][i].name
        ]
      },
      {
        'title': fetchIncidentMasterModel.data[4][0].typename,
        'items': [
          for (int i = 0; i < fetchIncidentMasterModel.data[4].length; i++)
            fetchIncidentMasterModel.data[4][i].name
        ]
      },
      {
        'title': fetchIncidentMasterModel.data[5][0].typename,
        'items': [
          for (int i = 0; i < fetchIncidentMasterModel.data[5].length; i++)
            fetchIncidentMasterModel.data[5][i].name
        ]
      },
      {
        'title': fetchIncidentMasterModel.data[6][0].typename,
        'items': [
          for (int i = 0; i < fetchIncidentMasterModel.data[6].length; i++)
            fetchIncidentMasterModel.data[6][i].name
        ]
      }
    ];
    return showCategory;
  }
}
