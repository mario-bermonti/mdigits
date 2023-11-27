/// Contains the data for a single session
class SessionModel {
  /// time at which the session started
  late final DateTime startTime;

  /// time at which the session ended
  late final DateTime endTime;

  @override
  String toString() {
    return 'Session info: start time: $startTime, end time: $endTime';
  }
}
