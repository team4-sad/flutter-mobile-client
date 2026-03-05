enum ConnectionStatus {
  none,
  exist;

  bool get isConnect => this == ConnectionStatus.exist;
}
