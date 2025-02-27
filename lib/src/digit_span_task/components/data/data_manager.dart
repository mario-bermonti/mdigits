import 'package:cognitive_data/databases/in_memory_db.dart';
import 'package:cognitive_data/models/device.dart';
import 'package:cognitive_data/models/session.dart';
import 'package:cognitive_data/models/trial.dart';
import 'package:cognitive_data/models/trial_type.dart';
import 'package:digit_span_tasks/digit_span_tasks.dart';
import 'package:digit_span_tasks/src/digit_span_task/components/config/ds_config.dart';
import 'package:get/get.dart';

import '../config/session_trial_type_map.dart';

/// Data manager for DigitSpanTask.
/// Used for adding data, getting data, and exporting data.
class DataManager extends GetxController {
  final InMemoryDB db = InMemoryDB();
  final DSConfig _config = Get.find();
  late final DateTime _startTime;
  late final DateTime _endTime;

  /// Adds data from a single trial to the in memory db.
  /// Given a [stim] and [resp], it defines a [Trial] and adds it to the db.
  /// The trial data includes the participantID, sessionID, and the
  /// [SessionType] (practice vs experimental) from the [_config].
  void addTrial({
    required String stim,
    required String resp,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    TrialType trialType =
        convertSessionToTrialType(_config.userConfig.sessionType);
    Trial trial = Trial(
      stim: stim,
      response: resp,
      participantID: _config.userConfig.participantID,
      sessionID: _config.userConfig.sessionID,
      trialType: trialType,
      startTime: startTime,
      endTime: endTime,
    );
    db.addTrial(trial: trial);
  }

  /// Sets the start time for the session.
  set startTime(DateTime time) {
    _startTime = time;
  }

  /// Sets the end time for the session.
  set endTime(DateTime time) {
    _endTime = DateTime.now();
  }

  /// Exports the data collected during the session.
  /// Includes data about the [trials] and metadata about the [session]
  /// and [device] used to collect the data.
  DigitSpanTaskData export() {
    collectMetadata();

    final DigitSpanTaskData data = DigitSpanTaskData(
      trials: db.trials,
      device: db.device,
      session: db.session,
    );

    return data;
  }

  /// Collect metadata for the current session.
  /// The metadata is added to the [InMemoryDB] and includes info about
  /// the [Device] used to collect the data and the [Session].
  void collectMetadata() {
    final UserConfig config = _config.userConfig;

    final Session session = Session(
      participantID: config.participantID,
      sessionID: config.sessionID,
      startTime: _startTime,
      endTime: _endTime,
    );
    db.addSession(session: session);

    final Device device = Device(
      participantID: config.participantID,
      sessionID: config.sessionID,
    );
    db.addDevice(device: device);
  }
}
