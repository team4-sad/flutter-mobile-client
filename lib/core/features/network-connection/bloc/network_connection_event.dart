part of 'network_connection_bloc.dart';

abstract class NetworkConnectionEvent {}

class ChangeNetworkConnectionEvent extends NetworkConnectionEvent {
  final ConnectionStatus connectionStatus;

  ChangeNetworkConnectionEvent({required this.connectionStatus});
}
