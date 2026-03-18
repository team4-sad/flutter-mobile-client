import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/academic-performance/models/academic_performance.dart';
import 'package:miigaik/features/academic-performance/widgets/item_academic_performance.dart';
import 'package:miigaik/theme/values.dart';

class AcademicPerformanceListWidget extends StatelessWidget {

  final SemesterAcademicPerformance performance;

  const AcademicPerformanceListWidget({super.key, required this.performance});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsetsGeometry.only(
          left: horizontalPaddingPage,
          right: horizontalPaddingPage,
          bottom: 60
        ),
        itemBuilder: (context, index) {
          return ItemAcademicPerformance(subject: performance.records[index]);
        },
        separatorBuilder: (context, index) => 10.vs(),
        itemCount: performance.records.length
      ),
    );
  }
}