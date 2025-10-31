import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final formattedDay = DateFormat("yyyy-MM-dd").format(day);
    final response = await dio.get(
      "group/$groupId",
      queryParameters: {"dateStart": formattedDay, "dateEnd": formattedDay},
    );

    final model = ResponseScheduleModel.fromMap(response.data);
    return model;
  }
}
