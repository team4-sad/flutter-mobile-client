part of 'academic_performance_cubit.dart';

sealed class AcademicPerformanceState {}

final class AcademicPerformanceInitialState extends AcademicPerformanceState {}

final class AcademicPerformanceLoadingState extends AcademicPerformanceState {}

final class AcademicPerformanceErrorState extends WithErrorState implements AcademicPerformanceState {
  AcademicPerformanceErrorState({required super.error});
}

final class AcademicPerformanceLoadedState extends WithAbsoluteDataState<SemesterAcademicPerformance> implements AcademicPerformanceState {
  AcademicPerformanceLoadedState({required super.data});
}
