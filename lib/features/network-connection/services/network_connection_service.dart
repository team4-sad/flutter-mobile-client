import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:miigaik/features/network-connection/enum/connection_status.dart';

class NetworkConnectionService {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final _controller = StreamController<ConnectionStatus>.broadcast();
  ConnectionStatus? _lastStatus;
  ConnectionStatus? get lastStatus => _lastStatus;

  void _connectivityListener(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      _lastStatus = ConnectionStatus.exist;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android: When both mobile and Wi-Fi are turned on system will
      // return Wi-Fi only as active network type
      _lastStatus = ConnectionStatus.exist;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      _lastStatus = ConnectionStatus.exist;
    } else {
      _lastStatus = ConnectionStatus.none;
    }
    _controller.add(_lastStatus!);
  }

  Future<void> launch() async {
    _connectivityListener(await Connectivity().checkConnectivity());
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      _connectivityListener
    );
  }

  void dispose(){
    _controller.close();
    _connectivitySubscription?.cancel();
  }

  Stream<ConnectionStatus> get onConnectionChanged =>
      _controller.stream.asBroadcastStream();
}