import 'dart:convert';

PermitDetailsModel permitDetailsModelFromJson(String str) =>
    PermitDetailsModel.fromJson(json.decode(str));

String permitDetailsModelToJson(PermitDetailsModel data) =>
    json.encode(data.toJson());

class PermitDetailsModel {
  final int? status;
  final String? message;
  final Data? data;

  PermitDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory PermitDetailsModel.fromJson(Map<String, dynamic> json) =>
      PermitDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class Data {
  final Tab1? tab1;
  final Tab2? tab2;
  final List<Tab3>? tab3;
  final List<Tab4>? tab4;
  final List<Tab5>? tab5;
  final List<dynamic>? tab6;

  Data({
    this.tab1,
    this.tab2,
    this.tab3,
    this.tab4,
    this.tab5,
    this.tab6,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tab1: json["tab1"] == null ? null : Tab1.fromJson(json["tab1"]),
        tab2: json["tab2"] == null ? null : Tab2.fromJson(json["tab2"]),
        tab3: json["tab3"] == null
            ? []
            : List<Tab3>.from(json["tab3"]!.map((x) => Tab3.fromJson(x))),
        tab4: json["tab4"] == null
            ? []
            : List<Tab4>.from(json["tab4"]!.map((x) => Tab4.fromJson(x))),
        tab5: json["tab5"] == null
            ? []
            : List<Tab5>.from(json["tab5"]!.map((x) => Tab5.fromJson(x))),
        tab6: json["tab6"] == null
            ? []
            : List<dynamic>.from(json["tab6"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tab1": tab1?.toJson(),
        "tab2": tab2?.toJson(),
        "tab3": tab3 == null
            ? []
            : List<dynamic>.from(tab3!.map((x) => x.toJson())),
        "tab4": tab4 == null
            ? []
            : List<dynamic>.from(tab4!.map((x) => x.toJson())),
        "tab5": tab5 == null
            ? []
            : List<dynamic>.from(tab5!.map((x) => x.toJson())),
        "tab6": tab6 == null ? [] : List<dynamic>.from(tab6!.map((x) => x)),
      };
}

class Tab1 {
  final String? id;
  final String? permit;
  final String? schedule;
  final String? location;
  final String? details;
  final String? status;
  final String? expired;
  final String? pnameNpi;
  final String? pname;
  final String? pcompany;
  final int? emergency;
  final String? isopen;
  final String? ishold;
  final String? isclose;
  final String? isnpiaccept;
  final String? isnpwaccept;
  final List<Maplink>? maplinks;
  final String? html;

  Tab1({
    this.id,
    this.permit,
    this.schedule,
    this.location,
    this.details,
    this.status,
    this.expired,
    this.pnameNpi,
    this.pname,
    this.pcompany,
    this.emergency,
    this.isopen,
    this.ishold,
    this.isclose,
    this.isnpiaccept,
    this.isnpwaccept,
    this.maplinks,
    this.html,
  });

  factory Tab1.fromJson(Map<String, dynamic> json) => Tab1(
        id: json["id"],
        permit: json["permit"],
        schedule: json["schedule"],
        location: json["location"],
        details: json["details"],
        status: json["status"],
        expired: json["expired"],
        pnameNpi: json["pname_npi"],
        pname: json["pname"],
        pcompany: json["pcompany"],
        emergency: json["emergency"],
        isopen: json["isopen"],
        ishold: json["ishold"],
        isclose: json["isclose"],
        isnpiaccept: json["isnpiaccept"],
        isnpwaccept: json["isnpwaccept"],
        maplinks: json["maplinks"] == null
            ? []
            : List<Maplink>.from(
                json["maplinks"]!.map((x) => Maplink.fromJson(x))),
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "permit": permit,
        "schedule": schedule,
        "location": location,
        "details": details,
        "status": status,
        "expired": expired,
        "pname_npi": pnameNpi,
        "pname": pname,
        "pcompany": pcompany,
        "emergency": emergency,
        "isopen": isopen,
        "ishold": ishold,
        "isclose": isclose,
        "isnpiaccept": isnpiaccept,
        "isnpwaccept": isnpwaccept,
        "maplinks": maplinks == null
            ? []
            : List<dynamic>.from(maplinks!.map((x) => x.toJson())),
        "html": html,
      };
}

class Maplink {
  final String? location;
  final String? name;
  final String? link;

  Maplink({
    this.location,
    this.name,
    this.link,
  });

  factory Maplink.fromJson(Map<String, dynamic> json) => Maplink(
        location: json["location"],
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "name": name,
        "link": link,
      };
}

class Tab2 {
  final int? id;
  final int? typeOfPermit;
  final int? permitNo;
  final dynamic safetyisolation;
  final dynamic safetyisolationinfo;
  final String? protectivemeasures;
  final dynamic generalMessage;
  final String? methodStatement;
  final String? specialWork;
  final String? specialppe;
  final String? layout;
  final String? layoutFile;
  final dynamic layoutLink;
  final List<Customfield>? customfields;

  Tab2({
    this.id,
    this.typeOfPermit,
    this.permitNo,
    this.safetyisolation,
    this.safetyisolationinfo,
    this.protectivemeasures,
    this.generalMessage,
    this.methodStatement,
    this.specialWork,
    this.specialppe,
    this.layout,
    this.layoutFile,
    this.layoutLink,
    this.customfields,
  });

  factory Tab2.fromJson(Map<String, dynamic> json) => Tab2(
        id: json["id"],
        typeOfPermit: json["type_of_permit"],
        permitNo: json["permit_no"],
        safetyisolation: json["safetyisolation"],
        safetyisolationinfo: json["safetyisolationinfo"],
        protectivemeasures: json["protectivemeasures"],
        generalMessage: json["general_message"],
        methodStatement: json["method_statement"],
        specialWork: json["special_work"],
        specialppe: json["specialppe"],
        layout: json["layout"],
        layoutFile: json["layout_file"],
        layoutLink: json["layout_link"],
        customfields: json["customfields"] == null
            ? []
            : List<Customfield>.from(
                json["customfields"]!.map((x) => Customfield.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_of_permit": typeOfPermit,
        "permit_no": permitNo,
        "safetyisolation": safetyisolation,
        "safetyisolationinfo": safetyisolationinfo,
        "protectivemeasures": protectivemeasures,
        "general_message": generalMessage,
        "method_statement": methodStatement,
        "special_work": specialWork,
        "specialppe": specialppe,
        "layout": layout,
        "layout_file": layoutFile,
        "layout_link": layoutLink,
        "customfields": customfields == null
            ? []
            : List<dynamic>.from(customfields!.map((x) => x.toJson())),
      };
}

class Customfield {
  final String? title;
  final dynamic fieldvalue;

  Customfield({
    this.title,
    this.fieldvalue,
  });

  factory Customfield.fromJson(Map<String, dynamic> json) => Customfield(
        title: json["title"],
        fieldvalue: json["fieldvalue"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "fieldvalue": fieldvalue,
      };
}

class Tab3 {
  final String? id;
  final String? name;
  final String? jobTitle;
  final String? company;
  final String? certificatecode;
  final String? npiId;
  final String? npwId;

  Tab3({
    this.id,
    this.name,
    this.jobTitle,
    this.company,
    this.certificatecode,
    this.npiId,
    this.npwId,
  });

  factory Tab3.fromJson(Map<String, dynamic> json) => Tab3(
        id: json["id"],
        name: json["name"],
        jobTitle: json["job_title"],
        company: json["company"],
        certificatecode: json["certificatecode"],
        npiId: json["npi_id"],
        npwId: json["npw_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "job_title": jobTitle,
        "company": company,
        "certificatecode": certificatecode,
        "npi_id": npiId,
        "npw_id": npwId,
      };
}

class Tab4 {
  final String? createdAt;
  final String? action;
  final String? createdBy;

  Tab4({
    this.createdAt,
    this.action,
    this.createdBy,
  });

  factory Tab4.fromJson(Map<String, dynamic> json) => Tab4(
        createdAt: json["created_at"],
        action: json["action"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "action": action,
        "created_by": createdBy,
      };
}

class Tab5 {
  final int? id;
  final String? name;
  final String? type;
  final String? files;

  Tab5({
    this.id,
    this.name,
    this.type,
    this.files,
  });

  factory Tab5.fromJson(Map<String, dynamic> json) => Tab5(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        files: json["files"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "files": files,
      };
}