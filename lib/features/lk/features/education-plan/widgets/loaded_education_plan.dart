import 'package:flutter/material.dart';
import 'package:miigaik/features/lk/features/education-plan/models/semester_education_plan_model.dart';

import 'education_plan_list_widget.dart';

class LoadedEducationPlan extends StatelessWidget {

  final PageController controller;
  final List<SemesterEducationPlanModel> plan;

  const LoadedEducationPlan({
    super.key,
    required this.controller,
    required this.plan
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, index){
          return EducationPlanListWidget(
            data: plan[index].plan,
          );
        },
        itemCount: plan.length,
      ),
    );
  }
}