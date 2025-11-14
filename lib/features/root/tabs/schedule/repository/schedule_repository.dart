import 'package:dio/dio.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
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

class MiigaikScheduleRepopsitory extends IScheduleRepository {
  final Dio dio;

  MiigaikScheduleRepopsitory({required this.dio});

  @override
  Future<ResponseAudienceScheduleModel> fetchDayAudienceSchedule({
    required String audienceId,
    required DateTime day,
  }) async {
    final response = await dio.get(
      "classroom/$audienceId",
      queryParameters: {"dateStart": day.yyyyMMdd, "dateEnd": day.yyyyMMdd},
    );
    return ResponseAudienceScheduleModel.fromMiigaikMap(response.data);
  }

  @override
  Future<ResponseGroupScheduleModel> fetchDayGroupSchedule({
    required String groupId,
    required DateTime day,
  }) async {
    final response = await dio.get(
      "group/$groupId",
      queryParameters: {"dateStart": day.yyyyMMdd, "dateEnd": day.yyyyMMdd},
    );
    return ResponseGroupScheduleModel.fromMiigaikMap(response.data);
  }

  @override
  Future<ResponseTeacherScheduleModel> fetchDayTeacherSchedule({
    required String teacherId,
    required DateTime day,
  }) async {
    final response = await dio.get(
      "teacher/$teacherId",
      queryParameters: {"dateStart": day.yyyyMMdd, "dateEnd": day.yyyyMMdd},
    );
    return ResponseTeacherScheduleModel.fromMiigaikMap(response.data);
  }
}

class ApiScheduleRepository extends IScheduleRepository {
  final Dio dio;

  ApiScheduleRepository({required this.dio});

  @override
  Future<ResponseGroupScheduleModel> fetchDayGroupSchedule({
    required String groupId,
    required DateTime day,
  }) async {
    final formattedDay = day.yyyyMMdd;
    final response = await dio.get(
      "schedule/group/$groupId",
      queryParameters: {"start_date": formattedDay, "end_date": formattedDay},
    );

    final model = ResponseGroupScheduleModel.fromMap(response.data);
    return model;
  }

  @override
  Future<ResponseAudienceScheduleModel> fetchDayAudienceSchedule({
    required String audienceId,
    required DateTime day,
  }) async {
    final formattedDay = day.yyyyMMdd;
    final response = await dio.get(
      "schedule/classroom/$audienceId",
      queryParameters: {"start_date": formattedDay, "end_date": formattedDay},
    );
    final model = ResponseAudienceScheduleModel.fromMap(response.data);
    return model;
  }

  @override
  Future<ResponseTeacherScheduleModel> fetchDayTeacherSchedule({
    required String teacherId,
    required DateTime day,
  }) async {
    final formattedDay = day.yyyyMMdd;
    final response = await dio.get(
      "schedule/teacher/$teacherId",
      queryParameters: {"start_date": formattedDay, "end_date": formattedDay},
    );
    final model = ResponseTeacherScheduleModel.fromMap(response.data);
    return model;
  }
}
