import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';

abstract class IScheduleRepository {
  Future<List<LessonModel>> fetchDayLessons({
    required String groupId,
    required DateTime day,
  });
}

class OtherApiScheduleRepository extends IScheduleRepository {
  final Dio otherApiDio;

  OtherApiScheduleRepository({required this.otherApiDio});

  @override
  Future<List<LessonModel>> fetchDayLessons({
    required String groupId,
    required DateTime day,
  }) async {
    final formattedDay = DateFormat("yyyy-MM-dd").format(day);
    final response = await otherApiDio.get(
      "group/$groupId",
      queryParameters: {"dateStart": formattedDay, "dateEnd": formattedDay},
    );
    final body = response.data as Map<String, dynamic>;
    final scheduleValue = body["schedule"] as Map<String, dynamic>;
    if (scheduleValue.keys.isEmpty) {
      return [];
    }
    final rawLessons = scheduleValue[scheduleValue.keys.first] as List;
    return rawLessons.map((e) => LessonModel.fromMap(e)).toList();
  }
}
