import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/education-plan/bloc/education_plan_cubit.dart';
import 'package:miigaik/features/lk/widgets/loading_semester_widget.dart';
import 'package:miigaik/features/lk/widgets/semesters_widget.dart';

class EducationPlanPage extends StatelessWidget {
  const EducationPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = GetIt.I.get<EducationPlanCubit>();
    cubit.fetchEducationPlan();
    return Scaffold(
      appBar: SimpleAppBar(title: "Учебный план"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<EducationPlanCubit, EducationPlanState>(
            bloc: cubit,
            builder: (context, state) {
              return switch(state) {
                EducationPlanInitial() => LoadingSemestersWidget(),
                EducationPlanLoading() => LoadingSemestersWidget(),
                EducationPlanLoaded(data: var plan) => SemestersWidget(
                  semesters: plan.map((e) => e.toEntity()).toList()
                ),
                EducationPlanError() => SizedBox()
              };
            },
          ),
          20.vs(),
          // BlocBuilder<EducationPlanCubit, EducationPlanState>(
          //   bloc: GetIt.I.get(),
          //   builder: (context, state) {
          //     return switch(state) {
          //       EducationPlanInitial() => LoadingSemestersWidget(),
          //       EducationPlanLoading() => LoadingSemestersWidget(),
          //       EducationPlanLoaded(data: var plan) => SemestersWidget(
          //         semesters: plan.map((e) => e.toEntity()).toList()
          //       ),
          //       EducationPlanError(error: var err) => PlaceholderWidget.fromException(err)
          //     };
          //   },
          // ),
        ],
      ),
    );
  }
}