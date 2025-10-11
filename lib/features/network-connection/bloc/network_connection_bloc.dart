import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/network-connection/enum/connection_status.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';

part 'network_connection_event.dart';
part 'network_connection_state.dart';

class NetworkConnectionBloc extends Bloc<NetworkConnectionEvent, NetworkConnectionState> {

  final NetworkConnectionService _service = GetIt.I.get();
  StreamSubscription<ConnectionStatus>? _subscription;

  void listen(){
    _subscription = _service.onConnectionChanged.listen((status){
      add(ChangeNetworkConnectionEvent(connectionStatus: status));
    });
  }

  void dispose(){
    _subscription?.cancel();
  }

  NetworkConnectionBloc():
    super(NetworkConnectionInitial()) {
      on<ChangeNetworkConnectionEvent>((event, emit) {
        switch(event.connectionStatus){
          case ConnectionStatus.none:
            emit(NoNetworkConnectionState());
          case ConnectionStatus.exist:
            emit(GoodNetworkConnectionState());
        }
      }, transformer: sequential());
  }
}
