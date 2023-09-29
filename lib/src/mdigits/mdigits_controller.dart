import 'package:get/get.dart';
import 'package:mdigits/src/data.dart';
import 'package:mdigits/src/mdigits/task_step.dart';
import 'package:mdigits/src/models/settings.dart';
import 'package:mdigits/src/stim/stim_controller.dart';
import 'package:mdigits/src/models/trial_data.dart';

/// Controls the task sequence
/// The task sequence which includes stim, response, rest, end
class MDigitsController extends GetxController {
  Config config;

  /// Provides access and manages the stimuli
  late StimController _stimuli;

  /// Data for all trials
  /// Used to provide data to app
  final Data data = Data();

  /// Identifies the step the task currently is in
  Rx<TaskStep> taskStep = TaskStep.instructions.obs;

  @override
  onInit() async {
    await setup();
    super.onInit();
  }

  MDigitsController(this.config);

  void addTrialData({required String resp}) {
    TrialData trialData = TrialData(
      participantID: config.participantID,
      stim: _stimuli.stim.currentStim,
      response: resp,
    );
    data.add(trialData);
  }

  // TODO improve name of conditions checks?
  /// TODO can presenting stim next be improved? Current implementation seems
  /// weird
  ///  Update the current task step so the [run()] can continue the sequence
  void updateStep() {
    if (_responseStatusFollows()) {
      taskStep(TaskStep.response);
    } else if (_completedStatusFollows()) {
      taskStep(TaskStep.completed);
    } else if (_stimStatusFollows()) {
      taskStep(TaskStep.stim);
    } else if (restStatusFollows()) {
      taskStep(TaskStep.rest);
    } else {
      taskStep(TaskStep.stim);
    }
  }

  bool _responseStatusFollows() => taskStep.value == TaskStep.stim;
  bool _stimStatusFollows() =>
      (taskStep.value == TaskStep.rest) ||
      (taskStep.value == TaskStep.instructions);
  bool restStatusFollows() =>
      _stimuli.stim.stimCountUsed != 0 && _stimuli.stim.stimCountUsed % 2 == 0;
  bool _completedStatusFollows() => _stimuli.stim.stimCountRemaining == 0;

  /// Setup everything needed to start the task sequence
  Future<void> setup() async {
    _stimuli = Get.put(StimController(stimList: config.stimList));
    await _stimuli.prepareStimPool();
  }

  Future<void> endSession() async {
    List<TrialData> datatoReturn = List<TrialData>.from(data);
    if (config.processData != null) {
      config.processData!(datatoReturn);
    }
    // await reset();
    Get.back(result: datatoReturn);
  }

  /// Reset mDigits so it can be used again repeatedly
  Future<void> reset() async {
    // data.clear();
    // await setup();
    taskStep(TaskStep.instructions);
  }
}
