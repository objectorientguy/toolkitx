import 'dart:convert';

class IncidentViewImageUtil {
  static List viewImageList(String fileName) {
    List files = [];
    files = jsonDecode(jsonEncode(fileName.split(',')));
    return files;
  }
}
