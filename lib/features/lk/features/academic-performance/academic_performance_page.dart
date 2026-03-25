import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/academic-performance/bloc/academic_performance_cubit.dart';
import 'package:miigaik/features/lk/features/academic-performance/widgets/loaded_academic_performance.dart';
import 'package:miigaik/features/lk/features/academic-performance/widgets/loading_performance_list_widget.dart';
import 'package:miigaik/features/lk/widgets/loading_semester_widget.dart';
import 'package:miigaik/features/lk/widgets/semesters_widget.dart';

class AcademicPerformancePage extends StatelessWidget {
  const AcademicPerformancePage({super.key});


  @override
  Widget build(BuildContext context) {

    late PageController pageController;

    final cubit = GetIt.I.get<AcademicPerformanceCubit>();
    cubit.fetchPerformance();

    return Scaffold(
      appBar: SimpleAppBar(title: "Успеваемость"),
      body: BlocBuilder<AcademicPerformanceCubit, AcademicPerformanceState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is AcademicPerformanceLoadedState){
            pageController = PageController(initialPage: state.data.length);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              switch(state){
                AcademicPerformanceInitialState() => LoadingSemestersWidget(),
                AcademicPerformanceLoadingState() => LoadingSemestersWidget(),
                AcademicPerformanceErrorState() => SizedBox(),
                AcademicPerformanceLoadedState(data: var semesters) => SemestersWidget(
                  controller: pageController,
                  semesters: semesters.map((e) => e.toEntity()).toList(),
                ),
              },
              20.vs(),
              switch(state){
                AcademicPerformanceInitialState() => LoadingPerformanceListWidget(),
                AcademicPerformanceLoadingState() => LoadingPerformanceListWidget(),
                AcademicPerformanceErrorState(error: var error) => PlaceholderWidget.fromException(
                  error
                ),
                AcademicPerformanceLoadedState(data: var performance) => LoadedAcademicPerformance(
                  controller: pageController,
                  performance: performance,
                )
              }
            ],
          );
        },
      ),
    );
  }
}