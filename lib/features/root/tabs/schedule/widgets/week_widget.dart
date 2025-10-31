import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_time_cubit/current_time_cubit.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_selected_day_bloc/schedule_selected_day_bloc.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class WeekWidget extends StatefulWidget {
  final void Function(DateTime) onTap;

  const WeekWidget({super.key, required this.onTap});

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  final bloc = GetIt.I.get<ScheduleSelectedDayBloc>();
  late DateTime dateTimeStartWeek;

  final _pageController = PageController(initialPage: 10000);

  @override
  void initState() {
    super.initState();
    dateTimeStartWeek = bloc.state.currentOnlyDate.startOfWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, pageIndex) {
          int realPageIndex = pageIndex - _pageController.initialPage;
          return Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: List.generate(7, (index) {
                final dateTime = dateTimeStartWeek.add(
                  Duration(days: index + realPageIndex * 7),
                );
                return GestureDetector(
                  onTap: () => widget.onTap(dateTime),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: _WeekItemWidget(dateTime: dateTime),
                  ),
                ).e();
              }),
            ),
          );
        },
      ),
    );
  }
}

class _WeekItemWidget extends StatelessWidget {
  final DateTime dateTime;

  const _WeekItemWidget({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final selectedDateBloc = GetIt.I.get<ScheduleSelectedDayBloc>();
    final currentDateBloc = GetIt.I.get<CurrentTimeCubit>();
    final weekName = dateTime.getWeekdayShortName(context.locale);
    return BlocBuilder<ScheduleSelectedDayBloc, ScheduleSelectedDayState>(
      bloc: selectedDateBloc,
      builder: (context, state) {
        final isSelect = state.currentOnlyDate == dateTime;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: (isSelect)
                ? context.palette.unAccent
                : context.palette.calendar,
            border: Border.all(
              color:
                  (currentDateBloc.state.currentDateTime.onlyDate() == dateTime)
                  ? context.palette.unAccent
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
    );
  }
}
