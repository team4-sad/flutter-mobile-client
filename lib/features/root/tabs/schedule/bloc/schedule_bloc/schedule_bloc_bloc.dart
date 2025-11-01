import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/with_error_state.dart';
import 'package:miigaik/features/network-connection/enum/connection_status.dart';
import 'package:miigaik/features/network-connection/exception/no_network_exception.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/root/tabs/schedule/models/response_schedule_model.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

part 'schedule_bloc_event.dart';
part 'schedule_bloc_state.dart';

class ScheduleBloc extends Bloc<ScheduleBlocEvent, ScheduleState> {
  final IScheduleRepository repository = GetIt.I.get();
  final NetworkConnectionService connectionService = GetIt.I.get();

  ScheduleBloc() : super(ScheduleInitial()) {
    connectionService.onConnectionChanged.listen((status) {
      if (status == ConnectionStatus.exist &&
          state is ScheduleError &&
          (state as ScheduleError).error is NoNetworkException) {
        final s = state as ScheduleError;
        add(FetchScheduleEvent(signature: s.signature, day: s.date));
      }
    });

    on<FetchScheduleEvent>((event, emit) async {
      if (state is! ScheduleLoading) {
        emit(ScheduleLoading());
      }
      if (connectionService.lastStatus != ConnectionStatus.exist) {
        emit(
          ScheduleError(
            error: NoNetworkException(),
            signature: event.signature,
            date: event.day,
          ),
        );
        return;
      }
      try {
        final response = await repository.fetchDaySchedule(
          groupId: event.signature.id,
          day: event.day,
        );
        final daySchedule = response.schedule.firstOrNull;
        emit(
          ScheduleLoaded(
            daySchedule: daySchedule,
            signature: event.signature,
            date: event.day,
          ),
        );
      } on Object catch (e) {
        emit(ScheduleError(error: e, signature: event.signature, date: event.day));
      }
    }, transformer: restartable());
  }
}
