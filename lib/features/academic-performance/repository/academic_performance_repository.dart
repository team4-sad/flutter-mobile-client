import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/academic-performance/models/academic_performance.dart';

abstract class IAcademicPerformanceRepository {
  Future<List<CourseAcademicPerformance>> fetchAcademicPerformance();
}

class ApiAcademicPerformanceRepository extends IAcademicPerformanceRepository {
  
  final Dio _dio;

  ApiAcademicPerformanceRepository({Dio? dio}) : _dio = dio ?? GetIt.I.get();
  
  @override
  Future<List<CourseAcademicPerformance>> fetchAcademicPerformance() async {
    final response = await _dio.get("lk/academic_records", options: Options(
      headers: {
        "Authorization": ""
      }
    ));
    final data = response.data as List;
    return data.map((e) => CourseAcademicPerformance.fromJson(e)).toList();
  }
}