import 'package:get/get.dart';
import 'package:mdigits/src/models/mdigits_data.dart';
import 'package:mdigits/src/models/trial_data.dart';
import 'package:mdigits/src/models/data_model.dart';

/// Data manager for MDigits
class Data extends GetxController {
  DataModel practiceData = DataModel();
  DataModel experimentalData = DataModel();

  /// Add data [participantID], [stim], [resp] from a single trial to
  /// the manager
  void addTrialData({
    required String participantID,
    required String stim,
    required String resp,
  }) {
    TrialData trialData = TrialData(
      participantID: participantID,
      stim: stim,
      response: resp,
    );
    _trialData.add(trialData);
  }

  /// Exports the data collected during the session using a custom object named
  /// [MDigitsData]
  MDigitsData export() {
    MDigitsData data = MDigitsData(
      trialData: _trialData,
      startTime: _startTime,
      endTime: _endTime,
    );

    return data;
  }
}
