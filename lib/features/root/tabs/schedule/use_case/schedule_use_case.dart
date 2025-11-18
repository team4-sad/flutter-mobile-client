import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/schedule/models/response_schedule_model.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

class FetchScheduleUseCase {
  final IScheduleRepository repository;

  FetchScheduleUseCase({
    IScheduleRepository? repo
  }): repository = repo ?? GetIt.I.get<IScheduleRepository>();

  Future<DayScheduleModel?> call(
    SignatureScheduleModel signature,
    DateTime day
  ) async {
    final response = await switch (signature.type) {
      SignatureScheduleType.group => repository.fetchDayGroupSchedule(
        groupId: signature.id,
        day: day,
      ),
      SignatureScheduleType.audience => repository.fetchDayAudienceSchedule(
        audienceId: signature.id,
        day: day,
      ),
      SignatureScheduleType.teacher => repository.fetchDayTeacherSchedule(
        teacherId: signature.id,
        day: day,
      ),
    };
    final daySchedule = response.schedule.firstOrNull;
    return daySchedule;
  }
}