import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdigits/src/end/end_view.dart';
import 'package:mdigits/src/instructions/instructions_view.dart';
import 'package:mdigits/src/mdigits/mdigits_controller.dart';
import 'package:mdigits/src/response/response_view.dart';
import 'package:mdigits/src/rest/rest_view.dart';
import 'package:mdigits/src/stim/stim_view.dart';
import 'package:mdigits/src/mdigits/task_step.dart';

/// Controls the task sequence based on the curren step
class MDigitsView extends StatelessWidget {
  MDigitsView({super.key});

  final MDigitsController mDigits =
      Get.put(MDigitsController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (mDigits.taskStep.value) {
        case TaskStep.instructions:
          return InstructionsView();
        case TaskStep.stim:
          return StimView();
        case TaskStep.response:
          return ResponseView();
        case TaskStep.rest:
          return RestView();
        case TaskStep.completed:
          // TODO should data be processed here
          if (mDigits.processData != null) {
            mDigits.processData!(mDigits.data);
          }
          return EndView();
      }
    });
  }
}
