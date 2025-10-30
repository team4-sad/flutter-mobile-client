import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/with_error_state.dart';
import 'package:miigaik/features/network-connection/enum/connection_status.dart';
import 'package:miigaik/features/network-connection/exception/no_network_exception.dart';
import 'package:miigaik/features/network-connection/services/network_connection_service.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';

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
        add(FetchScheduleEvent(groupId: s.groupId, day: s.date));
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
            groupId: event.groupId,
            date: event.day,
          ),
        );
        return;
      }
      try {
        final lessons = await repository.fetchDayLessons(
          groupId: event.groupId,
          day: event.day,
        );
        emit(
          ScheduleLoaded(
            lessons: lessons,
            groupId: event.groupId,
            date: event.day,
          ),
        );
      } on Object catch (e) {
        emit(ScheduleError(error: e, groupId: event.groupId, date: event.day));
      }
    }, transformer: restartable());
  }
}
