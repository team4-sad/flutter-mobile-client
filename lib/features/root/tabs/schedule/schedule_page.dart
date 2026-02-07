import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/extensions/string_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/schedule_selected_day_bloc/schedule_selected_day_bloc.dart';
import 'package:miigaik/features/root/tabs/schedule/content/main_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/calendar_widget.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/schedule_app_bar.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/sheet_widget.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/week_widget.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final controller = DraggableScrollableController();
  final bloc = GetIt.I.get<ScheduleSelectedDayBloc>();

  double sheetExtent = SheetWidget.maxSize;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onSheetChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onSheetChange);
    super.dispose();
  }

  void _onSheetChange() {
    setState(() {
      sheetExtent = controller.size;
    });
  }

  void _changeSelectedDateTime(DateTime dateTime) {
    bloc.add(SelectDayEvent(selectedDateTime: dateTime));
  }

  @override
  Widget build(BuildContext context) {
    final showWeek = sheetExtent >= 0.6;
    return Scaffold(
      backgroundColor: context.palette.calendar,
      appBar: ScheduleAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.02),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ...previousChildren, // предыдущий виджет снизу
                    if (currentChild != null)
                      currentChild, // новый поверх старого
                  ],
                );
              },
              child: showWeek
                  ? WeekWidget(
                      key: const ValueKey('week'),
                      onTap: _changeSelectedDateTime,
                    )
                  : CalendarWidget(
                      key: const ValueKey('calendar'),
                      onTap: _changeSelectedDateTime,
                    ),
            ),
          ),
          BlocBuilder<ScheduleSelectedDayBloc, ScheduleSelectedDayState>(
            bloc: bloc,
            builder: (context, state) {
              return SheetWidget(
                title: bloc.state.currentOnlyDate.ddMMMMyyyy.title,
                controller: controller,
                child: MainScheduleContent(),
              );
            },
          ),
        ],
      ),
    );
  }
}
