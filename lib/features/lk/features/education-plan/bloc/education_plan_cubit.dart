import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/features/lk/features/education-plan/models/semester_education_plan_model.dart';
import 'package:miigaik/features/lk/features/education-plan/use_case/get_education_plan_use_case.dart';

part 'education_plan_state.dart';

class EducationPlanCubit extends Cubit<EducationPlanState> {
  EducationPlanCubit() : super(EducationPlanInitial());

  final useCase = GetEducationPlanUseCase();

  void fetchEducationPlan() async {
    try {
      emit(EducationPlanLoading());
      final educationPlan = await useCase.call();
      final educationPlanBySemesters = educationPlan.expand((e) => e.semesters).toList();
      emit(EducationPlanLoaded(data: educationPlanBySemesters));
    } on Object catch(e){
      emit(EducationPlanError(error: e));
    }
  }
}
