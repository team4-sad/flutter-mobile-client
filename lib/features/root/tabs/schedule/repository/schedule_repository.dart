import 'package:dio/dio.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/root/tabs/schedule/models/response_schedule_model.dart';

abstract class IScheduleRepository {
  Future<ResponseScheduleModel> fetchDaySchedule({
    required String groupId,
    required DateTime day,
  });
}

class ApiScheduleRepository extends IScheduleRepository {
  final Dio dio;

  ApiScheduleRepository({required this.dio});

  @override
  Future<ResponseScheduleModel> fetchDaySchedule({
    required String groupId,
    required DateTime day,
  }) async {
    final formattedDay = day.yyyyMMdd;
    final response = await dio.get(
      "group/$groupId",
      queryParameters: {"dateStart": formattedDay, "dateEnd": formattedDay},
    );

    final model = ResponseScheduleModel.fromMap(response.data);
    return model;
  }
}
