import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/extensions/int_extensions.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_selected_day_bloc/schedule_selected_day_bloc.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  static const _daysInWeek = 7;

  final _bloc = GetIt.I.get<ScheduleSelectedDayBloc>();
  late DateTime _dateTimeStartMonth;

  @override
  void initState() {
    super.initState();
    _dateTimeStartMonth = _bloc.state.currentOnlyDate.startOfMonth();
  }

  void _addMonth(int month) {
    setState(() {
      _dateTimeStartMonth = DateTime(
        _dateTimeStartMonth.year,
        _dateTimeStartMonth.month + month,
        _dateTimeStartMonth.day,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final offsetLastMonth = _dateTimeStartMonth.weekday - 1;
    final countDays = _dateTimeStartMonth.calcCountDaysInMonth();
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                _addMonth(-1);
              },
              icon: Icon(
                I.leftarrow,
                color: context.palette.unAccent,
                size: 20,
              ),
            ),
            Text(
              _getMonthYear(_dateTimeStartMonth),
              style: TS.medium15.use(context.palette.unAccent),
              textAlign: TextAlign.center,
            ).e(),
            IconButton(
              onPressed: () {
                _addMonth(1);
              },
              icon: Icon(
                I.rightarrow,
                color: context.palette.unAccent,
                size: 20,
              ),
            ),
          ],
        ),
        GridView.builder(
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
              dateTime: _dateTimeStartMonth.add(Duration(days: dayIndex)),
            );
          },
        ).e(),
      ],
    );
  }

  String _getMonthYear(DateTime date) {
    String formatted = DateFormat("MMMM, yyyy", 'ru').format(date);
    final replacements = {
      'января': 'Январь',
      'февраля': 'Февраль',
      'марта': 'Март',
      'апреля': 'Апрель',
      'мая': 'Май',
      'июня': 'Июнь',
      'июля': 'Июль',
      'августа': 'Август',
      'сентября': 'Сентябрь',
      'октября': 'Октябрь',
      'ноября': 'Ноябрь',
      'декабря': 'Декабрь',
    };
    replacements.forEach((from, to) {
      if (formatted.contains(from)) {
        formatted = formatted.replaceAll(from, to);
      }
    });
    return formatted;
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
    final bloc = GetIt.I.get<ScheduleSelectedDayBloc>();
    final currentDate = DateTime.now().onlyDate();
    return (dateTime == null)
        ? SizedBox()
        : GestureDetector(
            onTap: () {
              bloc.add(SelectDayEvent(selectedDateTime: dateTime!));
            },
            child:
                BlocBuilder<ScheduleSelectedDayBloc, ScheduleSelectedDayState>(
                  bloc: bloc,
                  builder: (context, state) {
                    final isSelected = state.currentOnlyDate == dateTime!;
                    return Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        color: (isSelected)
                            ? context.palette.background
                            : Colors.transparent,
                        border: BoxBorder.all(
                          color: (currentDate == dateTime)
                              ? context.palette.unAccent
                              : Colors.transparent,
                        ),
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
