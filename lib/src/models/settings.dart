class Settings {
  final List<String> stimList;
  final String participantID;
  final void Function(List<TrialData> data)? processData;

  Settings(this.stimList, this.participantID, this.processData);
}
