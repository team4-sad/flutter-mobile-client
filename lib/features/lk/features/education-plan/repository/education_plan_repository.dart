import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/features/education-plan/models/course_education_plan_model.dart';

abstract class IEducationPlanRepository {
  Future<List<CourseEducationPlanModel>> fetchEducationPlan();
}

class ApiEducationPlanRepository extends IEducationPlanRepository {
  
  final Dio _dio;

  ApiEducationPlanRepository({Dio? dio}) : _dio = dio ?? GetIt.I.get();
  
  @override
  Future<List<CourseEducationPlanModel>> fetchEducationPlan() async {
    final response = await _dio.get("lk/education_plan", options: Options(
      headers: {
        "Authorization": ""
      }
    ));
    final data = response.data as List;
    return data.map((e) => CourseEducationPlanModel.fromJson(e)).toList();
  }
}