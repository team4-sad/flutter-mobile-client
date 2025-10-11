part of 'network_connection_bloc.dart';

abstract class NetworkConnectionState {}

final class NetworkConnectionInitial extends NetworkConnectionState {}

final class GoodNetworkConnectionState extends NetworkConnectionState {}
final class NoNetworkConnectionState extends NetworkConnectionState {}
