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
import 'package:miigaik/features/root/tabs/schedule/use_case/fetch_schedule_use_case.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'schedule_bloc_event.dart';
part 'schedule_bloc_state.dart';

class ScheduleBloc extends Bloc<ScheduleBlocEvent, ScheduleState> {

  final NetworkConnectionService connectionService = GetIt.I.get();
  final useCase = FetchScheduleUseCase();
  final talker = GetIt.I.get<Talker>();

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
        final daySchedule = await useCase.call(event.signature, event.day);
        emit(
          ScheduleLoaded(
            daySchedule: daySchedule,
            signature: event.signature,
            date: event.day,
          ),
        );
      } on Object catch (e) {
        talker.error("Ошибка при получении расписания", e);
        emit(
          ScheduleError(error: e, signature: event.signature, date: event.day),
        );
      }
    }, transformer: restartable());
  }
}
