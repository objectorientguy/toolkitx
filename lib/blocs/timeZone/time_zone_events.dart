abstract class TimeZoneEvents {}

class FetchTimeZone extends TimeZoneEvents {}

class SelectTimeZone extends TimeZoneEvents {
  final String timeZoneCode;
  final String timeZoneName;
  final bool isFromProfile;

  SelectTimeZone(
      {required this.timeZoneCode,
      required this.timeZoneName,
      this.isFromProfile = false});
}
