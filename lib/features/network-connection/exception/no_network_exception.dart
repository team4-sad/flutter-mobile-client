class NoNetworkException implements Exception {
  @override
  String toString() {
    return "Device not connected to internet";
  }
}