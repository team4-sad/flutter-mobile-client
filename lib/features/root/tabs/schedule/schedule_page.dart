import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_schedule.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/schedule_app_bar.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  // final SignatureScheduleBloc _signatureBloc = GetIt.I.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.lightText,
      appBar: ScheduleAppBar(),
      body: DraggableScrollableSheet(
        initialChildSize: 610.h / 1.sh ,
        minChildSize: 233.h / 1.sh,
        maxChildSize: 610.h / 1.sh,
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
                    child: CustomScrollView(
                      controller: controller,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsetsGeometry.symmetric(vertical: 30),
                          sliver: Text("Расписание", style: TS.medium20,).s()
                        ),
                        SliverList.separated(
                          itemBuilder: (context, index) => ItemSchedule(),
                          separatorBuilder: (context, index) => 15.vs(),
                        )
                      ],
                    ),
                  ),
                )
              ).e(),
            ],
          );
        },
      ),
    );
  }
}
