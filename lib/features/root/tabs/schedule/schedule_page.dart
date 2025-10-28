import 'package:flutter/material.dart';
import 'package:miigaik/features/root/tabs/schedule/content/main_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/calendar_widget.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/schedule_app_bar.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/sheet_widget.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/values.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.calendar,
      appBar: ScheduleAppBar(),
      body: Stack(
        children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingPage,
                vertical: 20
              ),
              child: CalendarWidget(),
            ),
            Expanded(
              child: SheetWidget(
                title: "Расписание", 
                child: MainScheduleContent()
              )
            ),
          ],
      ),
    );
  }
}
