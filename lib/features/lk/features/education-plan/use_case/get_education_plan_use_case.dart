import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/features/education-plan/models/course_education_plan_model.dart';
import 'package:miigaik/features/lk/features/education-plan/repository/education_plan_repository.dart';

class GetEducationPlanUseCase {
  final IEducationPlanRepository _repository;

  GetEducationPlanUseCase({IEducationPlanRepository? repository}):
    _repository = repository ?? GetIt.I.get();

  Future<List<CourseEducationPlanModel>> call() async {
    final response = await _repository.fetchEducationPlan();
    return response;
  }
}