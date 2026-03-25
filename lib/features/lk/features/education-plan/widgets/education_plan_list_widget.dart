import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/lk/features/education-plan/models/education_model.dart';
import 'package:miigaik/features/lk/features/education-plan/widgets/education_plan_item.dart';
import 'package:miigaik/theme/values.dart';

class EducationPlanListWidget extends StatelessWidget {

  final List<EducationDisciplineModel> data;

  const EducationPlanListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsGeometry.only(
        left: horizontalPaddingPage,
        right: horizontalPaddingPage,
        bottom: 60
      ),
      itemBuilder: (context, index) {
        return EducationPlanItem(
          educationDisciplineModel: data[index],
        );
      },
      separatorBuilder: (context, index) => 10.vs(),
      itemCount: data.length
    );
  }
}