import 'package:flutter/material.dart';
import 'package:miigaik/features/lk/features/academic-performance/models/academic_performance.dart';

import 'academic_performance_list_widget.dart';

class LoadedAcademicPerformance extends StatelessWidget {

  final PageController controller;
  final List<SemesterAcademicPerformance> performance;

  const LoadedAcademicPerformance({
    super.key,
    required this.controller,
    required this.performance
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, index){
          return AcademicPerformanceListWidget(
            performance: performance[index],
          );
        },
        itemCount: performance.length,
      ),
    );
  }

}