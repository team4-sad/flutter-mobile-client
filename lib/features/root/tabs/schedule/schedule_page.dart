import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/multi_bloc.dart';
import 'package:miigaik/features/common/bloc/with_error_state.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_day_bloc/current_day_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_bloc/schedule_bloc_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/content/empty_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/error_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/loaded_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/loading_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/content/schedule_not_selected_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/schedule_app_bar.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/week_widget.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final SignatureScheduleBloc signatureBloc = GetIt.I.get();
  final CurrentDayBloc currentDayBloc = GetIt.I.get();
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
    return Scaffold(
      backgroundColor: context.palette.calendar,
      appBar: ScheduleAppBar(),
      body: Column(
        children: [
          20.vs(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPaddingPage,
            ),
            child: WeekWidget(),
          ),
          20.vs(),
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: 233.h / 1.sh,
              maxChildSize: 1,
              snap: true,
              builder: (context, controller) {
                return Column(
                  spacing: 4,
                  children: [
                    Container(
                      width: 80.w,
                      height: 4,
                      decoration: BoxDecoration(
                        color: context.palette.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.palette.background,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPaddingPage,
                          ),
                          child: CustomScrollView(
                            controller: controller,
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 30,
                                ),
                                sliver: Text(
                                  "Расписание",
                                  style: TS.medium20,
                                ).s(),
                              ),
                              MultiBlocConsumer(
                                blocs: [
                                  signatureBloc,
                                  scheduleBloc,
                                  currentDayBloc,
                                ],
                                listener: (context, states) {
                                  final scheduleState = states
                                      .get<ScheduleState>();
                                  final currentDayState = states
                                      .get<CurrentDayState>();
                                  final signatureState = states
                                      .get<SignatureScheduleState>();
                                  if (scheduleState is ScheduleLoaded &&
                                      scheduleState.date !=
                                          currentDayState.currentDateTime) {
                                    _fetchSchedule();
                                  }
                                  if (signatureState
                                          is SignatureScheduleLoaded &&
                                      scheduleState is ScheduleInitial) {
                                    _fetchSchedule();
                                  }
                                },
                                builder: (context, states) {
                                  final signatureState = states
                                      .get<SignatureScheduleState>();
                                  final scheduleState = states
                                      .get<ScheduleState>();

                                  if (signatureState
                                          is SignatureScheduleLoaded &&
                                      !signatureState.hasSelected) {
                                    return ScheduleNotSelectedScheduleContent();
                                  }

                                  if (signatureState is WithErrorState ||
                                      scheduleState is WithErrorState) {
                                    final state =
                                        (signatureState is WithErrorState)
                                        ? signatureState
                                        : scheduleState;
                                    return ErrorScheduleContent(
                                      exception:
                                          (state as WithErrorState).error,
                                      onTap: () {
                                        _fetchSchedule();
                                      },
                                    );
                                  }

                                  if (scheduleState is ScheduleLoaded) {
                                    if (scheduleState.lessons.isEmpty) {
                                      return EmptyScheduleContent();
                                    }
                                    return LoadedScheduleContent(
                                      lessons: scheduleState.lessons,
                                    );
                                  }

                                  return LoadingScheduleContent();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).e(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
