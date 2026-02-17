import 'package:dio/dio.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/other/cache_helper.dart';
import 'package:miigaik/features/root/tabs/schedule/models/response_schedule_model.dart';

abstract class IScheduleRepository {
  Future<ResponseGroupScheduleModel> fetchDayGroupSchedule({
    required String groupId,
    required DateTime day,
  });

  Future<ResponseAudienceScheduleModel> fetchDayAudienceSchedule({
    required String audienceId,
    required DateTime day,
  });

  Future<ResponseTeacherScheduleModel> fetchDayTeacherSchedule({
    required String teacherId,
    required DateTime day,
  });
}

class ApiScheduleRepository extends IScheduleRepository {
  final Dio dio;
  final CacheHelper? cacheHelper;

  ApiScheduleRepository({required this.dio, this.cacheHelper});

  @override
  Future<ResponseGroupScheduleModel> fetchDayGroupSchedule({
    required String groupId,
    required DateTime day,
  }) async {
    final url = Uri(
      path: "schedule/group/$groupId",
      queryParameters: {"start_date": day.yyyyMMdd, "end_date": day.yyyyMMdd}
    ).toString();
    Map<String, dynamic>? data = await cacheHelper?.get(url);
    if (data == null) {
      final response = await dio.get(url);
      data = response.data;
      await cacheHelper?.save(url, data);
    }
    final model = ResponseGroupScheduleModel.fromMap(data!);
    return model;
  }

  @override
  Future<ResponseAudienceScheduleModel> fetchDayAudienceSchedule({
    required String audienceId,
    required DateTime day,
  }) async {
    final url = Uri(
      path: "schedule/classroom/$audienceId",
      queryParameters: {"start_date": day.yyyyMMdd, "end_date": day.yyyyMMdd},
    ).toString();
    Map<String, dynamic>? data = await cacheHelper?.get(url);
    if (data == null) {
      final response = await dio.get(url);
      data = response.data;
      await cacheHelper?.save(url, data);
    }
    final model = ResponseAudienceScheduleModel.fromMap(data!);
    return model;
  }

  @override
  Future<ResponseTeacherScheduleModel> fetchDayTeacherSchedule({
    required String teacherId,
    required DateTime day,
  }) async {
    final url = Uri(
      path: "schedule/teacher/$teacherId",
      queryParameters: {"start_date": day.yyyyMMdd, "end_date": day.yyyyMMdd},
    ).toString();
    Map<String, dynamic>? data = await cacheHelper?.get(url);
    if (data == null) {
      final response = await dio.get(url);
      data = response.data;
      await cacheHelper?.save(url, data);
    }
    final model = ResponseTeacherScheduleModel.fromMap(data!);
    return model;
  }
}
