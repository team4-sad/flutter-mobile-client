import 'package:get_it/get_it.dart';
import 'package:miigaik/features/academic-performance/models/academic_performance.dart';
import 'package:miigaik/features/academic-performance/repository/academic_performance_repository.dart';

class GetAcademicPerformanceUseCase {

  final IAcademicPerformanceRepository _repository;

  GetAcademicPerformanceUseCase({IAcademicPerformanceRepository? repository}):
    _repository = repository ?? GetIt.I.get();

  Future<List<CourseAcademicPerformance>> call() async {
    final performance = await _repository.fetchAcademicPerformance();
    return performance;
  }
}