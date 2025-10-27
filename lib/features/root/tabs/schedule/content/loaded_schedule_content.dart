import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_schedule.dart';

class LoadedScheduleContent extends StatelessWidget {
  const LoadedScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) => ItemSchedule(),
      separatorBuilder: (context, index) => 15.vs(),
    );
  }
}
