import 'package:dio/dio.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

abstract class INewSignatureScheduleRepository {
  Future<List<SignatureScheduleModel>> fetchGroups(String groupName);
  Future<List<SignatureScheduleModel>> fetchAudiences(String audience);
  Future<List<SignatureScheduleModel>> fetchTeachers(String teacher);
}

class ApiNewSignatureScheduleRepository extends INewSignatureScheduleRepository {
  final Dio dio;

  ApiNewSignatureScheduleRepository({required this.dio});

  @override
  Future<List<SignatureScheduleModel>> fetchAudiences(String audience) async {
    final response = await dio.get("schedule/classrooms/$audience");
    final data = response.data as List;
    return data.map(
      (e) => SignatureScheduleModel.fromAudienceMap(e as Map<String, dynamic>)
    ).toList();
  }

  @override
  Future<List<SignatureScheduleModel>> fetchGroups(String groupName) async {
    final response = await dio.get("schedule/groups/$groupName");
    final data = response.data as List;
    return data.map(
      (e) => SignatureScheduleModel.fromGroupMap(e as Map<String, dynamic>)
    ).toList();
  }

  @override
  Future<List<SignatureScheduleModel>> fetchTeachers(String teacher) async {
    final response = await dio.get("schedule/teachers/$teacher");
    final data = response.data as List;
    return data.map(
      (e) => SignatureScheduleModel.fromTeacherMap(e as Map<String, dynamic>)
    ).toList();
  }
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
