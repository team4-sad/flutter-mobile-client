import 'package:dio/dio.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

abstract class INewSignatureScheduleRepository {
  Future<List<SignatureScheduleModel>> fetchGroups(String groupName);
  Future<List<SignatureScheduleModel>> fetchAudiences(String audience);
  Future<List<SignatureScheduleModel>> fetchTeachers(String teacher);
}

class MiigaikApiSignatureScheduleRepository
    extends INewSignatureScheduleRepository {
  final Dio dio;

  MiigaikApiSignatureScheduleRepository({required this.dio});

  @override
  Future<List<SignatureScheduleModel>> fetchAudiences(String audience) async {
    final response = await dio.get(
      "search/classroom",
      queryParameters: {"classroomName": audience},
    );
    final data = (response.data as List)
        .map(
          (e) => SignatureScheduleModel(
            type: SignatureScheduleType.audience,
            title: e["classroomName"].toString(),
            id: e["classroomId"].toString(),
          ),
        )
        .toList();
    return data;
  }

  @override
  Future<List<SignatureScheduleModel>> fetchGroups(String groupName) async {
    final response = await dio.get(
      "search/group",
      queryParameters: {"groupName": groupName},
    );
    return (response.data as List)
        .map(
          (e) => SignatureScheduleModel(
            type: SignatureScheduleType.group,
            title: e["groupName"].toString(),
            id: e["id"].toString(),
          ),
        )
        .toList();
  }

  @override
  Future<List<SignatureScheduleModel>> fetchTeachers(String teacher) async {
    final response = await dio.get(
      "search/teacher",
      queryParameters: {"teacherFullName": teacher},
    );
    return (response.data as List)
        .map(
          (e) => SignatureScheduleModel(
            type: SignatureScheduleType.teacher,
            title:
                "${e["teacher"]["lastName"].toString()} ${e["teacher"]["firstName"].toString()} ${e["teacher"]["patronymic"].toString()}",
            id: e["id"].toString(),
          ),
        )
        .toList();
  }
}
