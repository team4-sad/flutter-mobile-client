import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/academic-performance/bloc/academic_performance_cubit.dart';
import 'package:miigaik/features/lk/features/academic-performance/widgets/academic_performance_list_widget.dart';
import 'package:miigaik/features/lk/features/academic-performance/widgets/loading_performance_list_widget.dart';
import 'package:miigaik/features/lk/widgets/loading_semester_widget.dart';
import 'package:miigaik/features/lk/widgets/semesters_widget.dart';

class AcademicPerformancePage extends StatelessWidget {
  AcademicPerformancePage({super.key});

  final cubit = GetIt.I.get<AcademicPerformanceCubit>();

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    cubit.fetchPerformance();
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Успеваемость",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<AcademicPerformanceCubit, AcademicPerformanceState>(
        bloc: cubit,
        builder: (context, state) {
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
                AcademicPerformanceErrorState(error: var error) => PlaceholderWidget.fromException(error),
                AcademicPerformanceLoadedState(data: var performance) => Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    reverse: true,
                    itemBuilder: (context, index){
                      return AcademicPerformanceListWidget(
                        performance: performance[performance.length-1-index],
                      );
                    },
                    itemCount: performance.length,
                  ),
                )
              }
            ],
          );
        },
      ),
    );
  }
}