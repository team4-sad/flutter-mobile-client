import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/features/lk/features/academic-performance/models/academic_performance.dart';
import 'package:miigaik/features/lk/features/academic-performance/use_case/get_academic_performance_use_case.dart';

part 'academic_performance_state.dart';

class AcademicPerformanceCubit extends Cubit<AcademicPerformanceState> {

  final useCase = GetAcademicPerformanceUseCase();

  AcademicPerformanceCubit() : super(AcademicPerformanceInitialState());

  void fetchPerformance() async {
    try {
      emit(AcademicPerformanceLoadingState());
      final coursesPerformance = await useCase();
      final semestersPerformance = coursesPerformance.expand((e) => e.records).toList();
      emit(AcademicPerformanceLoadedState(data: semestersPerformance));
    } on Object catch(e){
      emit(AcademicPerformanceErrorState(error: e));
    }
  }
}
