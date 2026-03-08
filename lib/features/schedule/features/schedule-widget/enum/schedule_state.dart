enum ScheduleState {
  loading("loading"),
  loaded("loaded"),
  error("error");

  final String value;

  const ScheduleState(this.value);
}