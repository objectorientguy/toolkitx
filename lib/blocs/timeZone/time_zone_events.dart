abstract class TimeZoneEvents {}

class FetchTimeZone extends TimeZoneEvents {}

class SelectTimeZone extends TimeZoneEvents {
  final String timeZoneCode;
  SelectTimeZone({required this.timeZoneCode});
}
