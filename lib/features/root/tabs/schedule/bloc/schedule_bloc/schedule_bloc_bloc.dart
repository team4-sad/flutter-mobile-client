import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/with_error_state.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';

part 'schedule_bloc_event.dart';
part 'schedule_bloc_state.dart';

class ScheduleBloc extends Bloc<ScheduleBlocEvent, ScheduleState> {
  final IScheduleRepository repository = GetIt.I.get();

  ScheduleBloc() : super(ScheduleInitial()) {
    on<FetchScheduleEvent>((event, emit) async {
      if (state is! ScheduleLoading) {
        emit(ScheduleLoading());
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
        emit(ScheduleError(error: e));
      }
    }, transformer: restartable());
  }
}
