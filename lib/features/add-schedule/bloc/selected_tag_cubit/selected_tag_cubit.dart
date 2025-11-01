import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';

class SelectedTagCubit extends Cubit<SignatureScheduleType> {
  SelectedTagCubit() : super(SignatureScheduleType.group);

  void setType(SignatureScheduleType newType) {
    if (newType != state) {
      emit(newType);
    }
  }
}
