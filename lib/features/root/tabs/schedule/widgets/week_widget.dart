import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_day_bloc/current_day_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class WeekWidget extends StatelessWidget {
  const WeekWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _WeekItemWidget(dateTime: DateTime.parse("2025-10-27")),
        _WeekItemWidget(dateTime: DateTime.parse("2025-10-28")),
        _WeekItemWidget(dateTime: DateTime.parse("2025-10-29")),
        _WeekItemWidget(dateTime: DateTime.parse("2025-10-30")),
        _WeekItemWidget(dateTime: DateTime.parse("2025-10-31")),
        _WeekItemWidget(dateTime: DateTime.parse("2025-11-01")),
        _WeekItemWidget(dateTime: DateTime.parse("2025-11-02")),
      ],
    );
  }
}

class _WeekItemWidget extends StatelessWidget {
  final DateTime dateTime;

  const _WeekItemWidget({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I.get<CurrentDayBloc>();
    final weekName = getWeekdayShortName(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          bloc.add(SelectDayEvent(selectedDateTime: dateTime));
        },
        child: BlocBuilder<CurrentDayBloc, CurrentDayState>(
          bloc: bloc,
          builder: (context, state) {
            final isSelect = state.currentOnlyDate == dateTime;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: (isSelect)
                    ? context.palette.unAccent
                    : context.palette.calendar,
              ),
              child: Column(
                children: [
                  Text(
                    weekName,
                    style: TS.medium15.use(
                      (isSelect)
                          ? context.palette.calendar
                          : context.palette.unAccent,
                    ),
                  ),
                  32.vs(),
                  Text(
                    dateTime.day.toString(),
                    style: TS.medium15.use(
                      (isSelect)
                          ? context.palette.calendar
                          : context.palette.unAccent,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String getWeekdayShortName(BuildContext context) {
    final int weekday = dateTime.weekday;
    if (weekday < 1 || weekday > 7) {
      throw ArgumentError('День недели должен быть от 1 до 7');
    }
    final date = DateTime(2024, 1, weekday);
    final formatter = DateFormat.E(context.locale.countryCode);
    final shortName = formatter.format(date);
    return shortName.substring(0, 2).toLowerCase();
  }
}
