class Settings {
  /// List of stim to present to the user
  late final List<String> stimList;
  final String participantID;
  final void Function(List<TrialData> data)? processData;

    stimList = randomizeDigitsInSets(stimList);
}
