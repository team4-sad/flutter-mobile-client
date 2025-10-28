import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/content/main_schedule_content.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/calendar_widget.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/schedule_app_bar.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
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
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 233.h / 1.sh,
                maxChildSize: 0.8,
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
                                MainScheduleContent()
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
