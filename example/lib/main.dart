// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digit_span_tasks/digit_span_tasks.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DigitSpanTasks',
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Simulate participant info
  final String participantID = '101';
  final String sessionID = '001';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => runDigitSpanForward(
                participantID: widget.participantID,
                sessionID: widget.sessionID,
              ),
              child: Text(
                'Digit Span Forward',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => runDigitSpanBackwards(
                participantID: widget.participantID,
                sessionID: widget.sessionID,
              ),
              child: Text(
                'Digit Span Backwards',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }

  void runDigitSpanForward({
    required String participantID,
    required String sessionID,
  }) async {
    // Setup variables for task
    DigitSpanTask task;
    DigitSpanTaskData data;

    // Define config for practice session
    UserConfig practiceConfig = UserConfig(
      minStimSize: 2,
      maxStimSize: 2,
      countEachSize: 1,
      participantID: participantID,
      sessionID: sessionID,
      sessionType: SessionType.practice,
      restInstructions: const RestInstructions(),
    );
    // Setup task
    task = DigitSpanTask(config: practiceConfig);
    await Get.to(StartPage());
    // Run task
    data = await task.run();
    print(data);

    // Define config for experimental session
    UserConfig experimentalConfig = UserConfig(
      minStimSize: 4,
      maxStimSize: 5,
      countEachSize: 1,
      participantID: participantID,
      sessionID: sessionID,
      sessionType: SessionType.experimental,
      restInstructions: const RestInstructions(),
    );
    task = DigitSpanTask(config: experimentalConfig);
    await Get.to(StartPage());
    data = await task.run();
    print(data);
  }

  void runDigitSpanBackwards({
    required String participantID,
    required String sessionID,
  }) async {
    UserConfig config = UserConfig(
      minStimSize: 6,
      maxStimSize: 6,
      countEachSize: 1,
      participantID: participantID,
      sessionID: sessionID,
      restInstructions: const RestInstructions(),
      sessionType: SessionType.experimental,
    );
    final task = DigitSpanTask(config: config);
    await Get.to(StartPage());
    final DigitSpanTaskData data = await task.run();
    print(data);
  }
}

/// Ask participants if they are ready
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              child: Text(
                'Continuar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestInstructions extends StatelessWidget {
  const RestInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Toma un descanso',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        Text(
          'Respira profundo antes de continuar',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
