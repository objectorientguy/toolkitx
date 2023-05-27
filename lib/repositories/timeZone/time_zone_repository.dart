import '../../data/models/timeZones/time_zone_model.dart';

abstract class TimeZoneRepository {
  Future<GetTimeZoneModel> fetchTimeZone();
}
