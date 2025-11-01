import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/add-schedule/repository/signature_schedule_repository.dart';
import 'package:miigaik/features/common/bloc/with_data_state.dart';
import 'package:miigaik/features/common/bloc/with_error_state.dart';
import 'package:miigaik/features/network-connection/enum/connection_status.dart';
import 'package:miigaik/features/network-connection/exception/no_network_exception.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

part 'new_signatures_event.dart';
part 'new_signatures_state.dart';

class NewSignaturesBloc extends Bloc<NewSignaturesEvent, NewSignaturesState> {
  final repository = GetIt.I.get<INewSignatureScheduleRepository>();
  final connectionService = GetIt.I.get<NetworkConnectionService>();

  NewSignaturesBloc() : super(NewSignaturesInitial()) {
    connectionService.onConnectionChanged.listen((status) {
      if (status == ConnectionStatus.exist &&
          state is NewSignaturesError &&
          (state as NewSignaturesError).error is NoNetworkException) {
        final s = state as NewSignaturesError;
        add(
          FetchNewSignaturesEvent(
            searchText: s.searchText,
            searchType: s.searchType,
          ),
        );
      }
    });

    on<ClearNewSignaturesEvent>((event, emit) => emit(NewSignaturesInitial()));

    on<FetchNewSignaturesEvent>((event, emit) async {
      if (event.searchText.isEmpty) {
        return;
      }

      if (connectionService.lastStatus != ConnectionStatus.exist) {
        emit(
          NewSignaturesError(
            error: NoNetworkException(),
            searchText: event.searchText,
            searchType: event.searchType,
          ),
        );
        return;
      }

      if (state is! NewSignaturesLoading) {
        emit(
          NewSignaturesLoading(
            searchText: event.searchText,
            searchType: event.searchType,
          ),
        );
      }

      try {
        final future = switch (event.searchType) {
          SignatureScheduleType.group => repository.fetchGroups(
            event.searchText,
          ),
          SignatureScheduleType.audience => repository.fetchAudiences(
            event.searchText,
          ),
          SignatureScheduleType.teacher => repository.fetchTeachers(
            event.searchText,
          ),
        };
        final response = await future;
        emit(NewSignaturesLoaded(data: response));
      } on Object catch (e) {
        emit(
          NewSignaturesError(
            error: e,
            searchText: event.searchText,
            searchType: event.searchType,
          ),
        );
      }
    }, transformer: restartable());
  }
}
