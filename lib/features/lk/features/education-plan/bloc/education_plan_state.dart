part of 'education_plan_cubit.dart';

sealed class EducationPlanState {}

final class EducationPlanInitial extends EducationPlanState {}
final class EducationPlanLoading extends EducationPlanState {}
final class EducationPlanLoaded extends WithAbsoluteDataState<SemesterEducationPlanModel> implements EducationPlanState {
  EducationPlanLoaded({required super.data});
}
final class EducationPlanError extends WithErrorState implements EducationPlanState {
  EducationPlanError({required super.error});
}
