import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_selected_day_bloc/schedule_selected_day_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class WeekWidget extends StatelessWidget {
  const WeekWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I.get<ScheduleSelectedDayBloc>();
    final dateTimeStartWeek = bloc.state.currentOnlyDate.startOfWeek();
    return Row(
      children: List.generate(
        7,
        (index) => _WeekItemWidget(
          dateTime: dateTimeStartWeek.add(Duration(days: index)),
        ),
      ),
    );
  }
}

class _WeekItemWidget extends StatelessWidget {
  final DateTime dateTime;

  const _WeekItemWidget({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I.get<ScheduleSelectedDayBloc>();
    final weekName = bloc.state.currentOnlyDate.getWeekdayShortName(
      context.locale,
    );
    return Expanded(
      child: GestureDetector(
        onTap: () {
          bloc.add(SelectDayEvent(selectedDateTime: dateTime));
        },
        child: BlocBuilder<ScheduleSelectedDayBloc, ScheduleSelectedDayState>(
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
}
