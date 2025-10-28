import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/extensions/int_extensions.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_day_bloc/current_day_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  static const _daysInWeek = 7;

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I.get<CurrentDayBloc>();
    final selected = bloc.state.currentOnlyDate;
    final dateTimeStartMonth = selected.startOfMonth();
    final offsetLastMonth = selected.weekday;
    final countDays = selected.calcCountDaysInMonth();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _daysInWeek,
        childAspectRatio: 1,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemCount: countDays + offsetLastMonth + _daysInWeek,
      itemBuilder: (context, index) {
        if (index < _daysInWeek) {
          return _WeekDayWidget(
            weekday: (index + 1).asWeekdayShortName(context.locale),
          );
        }
        if (index < (offsetLastMonth + _daysInWeek)) {
          return _DayCalendarWidget();
        }
        final dayIndex = index - offsetLastMonth - _daysInWeek;
        return _DayCalendarWidget(
          dateTime: dateTimeStartMonth.add(Duration(days: dayIndex)),
        );
      },
    );
  }
}

class _WeekDayWidget extends StatelessWidget {
  final String weekday;

  const _WeekDayWidget({required this.weekday});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Center(
        child: Text(weekday, style: TS.medium15.use(context.palette.unAccent)),
      ),
    );
  }
}

class _DayCalendarWidget extends StatelessWidget {
  final DateTime? dateTime;

  const _DayCalendarWidget({this.dateTime});

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I.get<CurrentDayBloc>();
    return (dateTime == null)
        ? SizedBox()
        : GestureDetector(
            onTap: () {
              bloc.add(SelectDayEvent(selectedDateTime: dateTime!));
            },
            child: BlocBuilder<CurrentDayBloc, CurrentDayState>(
              bloc: bloc,
              builder: (context, state) {
                final isSelected = state.currentOnlyDate == dateTime!;
                return Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                    color: (isSelected)
                        ? context.palette.background
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      dateTime!.day.toString(),
                      style: TS.regular15.use(
                        (isSelected)
                            ? context.palette.calendar
                            : context.palette.unAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
