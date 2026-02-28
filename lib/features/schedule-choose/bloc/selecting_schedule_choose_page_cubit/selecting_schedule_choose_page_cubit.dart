import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

class SelectingScheduleChoosePageCubit extends Cubit<List<SignatureScheduleModel>?> {
  SelectingScheduleChoosePageCubit() : super(null);

  void onSelect(SignatureScheduleModel selected){
    if (state == null){
      emit([selected]);
    } else if (state!.contains(selected)){
      emit(state!.where((e) => e != selected).toList());
    } else{
      emit([...state!, selected]);
    }
  }

  void allSelect(List<SignatureScheduleModel> selected){
    emit(selected);
  }

  void clear(){
    emit([]);
  }

  void disableSelectionMode(){
    emit(null);
  }

  bool get isSelectionMode => state != null;
}
