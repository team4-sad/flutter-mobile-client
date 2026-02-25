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

  ApiScheduleRepository({required this.dio});

  @override
  Future<ResponseGroupScheduleModel> fetchDayGroupSchedule({
    required String groupId,
    required DateTime day,
  }) async {
    final response = await dio.get(
      "schedule/group/$groupId",
      queryParameters: {"start_date": day.yyyyMMdd, "end_date": day.yyyyMMdd}
    );
    final model = ResponseGroupScheduleModel.fromMap(response.data);
    return model;
  }

  @override
  Future<ResponseAudienceScheduleModel> fetchDayAudienceSchedule({
    required String audienceId,
    required DateTime day,
  }) async {
    final response = await dio.get("schedule/classroom/$audienceId", queryParameters: {
      "start_date": day.yyyyMMdd,
      "end_date": day.yyyyMMdd
    });
    final model = ResponseAudienceScheduleModel.fromMap(response.data);
    return model;
  }

  @override
  Future<ResponseTeacherScheduleModel> fetchDayTeacherSchedule({
    required String teacherId,
    required DateTime day,
  }) async {
    final response = await dio.get(
      "schedule/teacher/$teacherId",
      queryParameters: {"start_date": day.yyyyMMdd, "end_date": day.yyyyMMdd}
    );
    final model = ResponseTeacherScheduleModel.fromMap(response.data);
    return model;
  }
}

class CachedApiScheduleRepository extends ApiScheduleRepository {
  final CacheHelper? cacheHelper;

  CachedApiScheduleRepository({required super.dio, this.cacheHelper});

  @override
  Future<ResponseGroupScheduleModel> fetchDayGroupSchedule({
    required String groupId,
    required DateTime day,
  }) async {
    final key = "group_${groupId}_${day.toIso8601String()}";
    Map<String, dynamic>? data = await cacheHelper?.get(key);
    if (data == null) {
      final model = await super.fetchDayGroupSchedule(groupId: groupId, day: day);
      await cacheHelper?.save(key, model.toMap());
      return model;
    }
    final model = ResponseGroupScheduleModel.fromMap(data);
    return model;
  }

  @override
  Future<ResponseAudienceScheduleModel> fetchDayAudienceSchedule({
    required String audienceId,
    required DateTime day,
  }) async {
    final key = "audience_${audienceId}_${day.toIso8601String()}";
    Map<String, dynamic>? data = await cacheHelper?.get(key);
    if (data == null) {
      final model = await super.fetchDayAudienceSchedule(audienceId: audienceId, day: day);
      await cacheHelper?.save(key, model.toMap());
      return model;
    }
    final model = ResponseAudienceScheduleModel.fromMap(data);
    return model;
  }

  @override
  Future<ResponseTeacherScheduleModel> fetchDayTeacherSchedule({
    required String teacherId,
    required DateTime day,
  }) async {
    final key = "teacher_${teacherId}_${day.toIso8601String()}";
    Map<String, dynamic>? data = await cacheHelper?.get(key);
    if (data == null) {
      final model = await super.fetchDayTeacherSchedule(teacherId: teacherId, day: day);
      await cacheHelper?.save(key, model.toMap());
      return model;
    }
    final model = ResponseTeacherScheduleModel.fromMap(data);
    return model;
  }
}
