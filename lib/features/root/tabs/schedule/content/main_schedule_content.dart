import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/multi_bloc.dart';
import 'package:miigaik/features/common/bloc/with_error_state.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_selected_day_bloc/schedule_selected_day_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_bloc/schedule_bloc_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/content/empty_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/error_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/loaded_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/loading_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/schedule_not_selected_schedule_content.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';

class MainScheduleContent extends StatelessWidget {
  MainScheduleContent({super.key});

  final SignatureScheduleBloc signatureBloc = GetIt.I.get();
  final ScheduleSelectedDayBloc currentDayBloc = GetIt.I.get();
  final ScheduleBloc scheduleBloc = GetIt.I.get();

  void _fetchSchedule() {
    final signatureState = signatureBloc.state;
    final currentDayState = currentDayBloc.state;
    if (signatureState is SignatureScheduleLoaded &&
        signatureState.hasSelected) {
      scheduleBloc.add(
        FetchScheduleEvent(
          day: currentDayState.currentDateTime,
          groupId: signatureState.selected!.id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocConsumer(
      blocs: [signatureBloc, scheduleBloc, currentDayBloc],
      listener: (context, states) {
        final scheduleState = states.get<ScheduleState>();
        final currentDayState = states.get<ScheduleSelectedDayState>();
        final signatureState = states.get<SignatureScheduleState>();

        if (scheduleState is ScheduleLoaded &&
            scheduleState.date != currentDayState.currentDateTime) {
          _fetchSchedule();
        }
        if (signatureState is SignatureScheduleLoaded &&
            scheduleState is ScheduleInitial) {
          _fetchSchedule();
        }
      },
      builder: (context, states) {
        final signatureState = states.get<SignatureScheduleState>();
        final scheduleState = states.get<ScheduleState>();

        if (signatureState is SignatureScheduleLoaded &&
            !signatureState.hasSelected) {
          return ScheduleNotSelectedScheduleContent();
        }

        if (signatureState is WithErrorState ||
            scheduleState is WithErrorState) {
          final state = (signatureState is WithErrorState)
              ? signatureState
              : scheduleState;
          return ErrorScheduleContent(
            exception: (state as WithErrorState).error,
            onTap: () {
              _fetchSchedule();
            },
          );
        }

        if (scheduleState is ScheduleLoaded) {
          if (scheduleState.lessons.isEmpty) {
            return EmptyScheduleContent();
          }
          return LoadedScheduleContent(lessons: scheduleState.lessons);
        }

        return LoadingScheduleContent();
      },
    );
  }
}
