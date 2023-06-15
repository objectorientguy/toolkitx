abstract class HeaderEvent {}

class FetchEditHeader extends HeaderEvent {
  final String scheduleId;

  FetchEditHeader({required this.scheduleId});
}

class SubmitHeader extends HeaderEvent {
  final String scheduleId;
  final List submitHeaderList;

  SubmitHeader({required this.scheduleId, required this.submitHeaderList});
}
