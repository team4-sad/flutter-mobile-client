import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miigaik/features/root/tabs/notes/enum/notes_mode.dart';

class NotesModeCubit extends Cubit<NotesMode> {
  NotesModeCubit() : super(NotesMode.list);

  void toggleMode(){
    if (state == NotesMode.list){
      emit(NotesMode.search);
    } else {
      emit(NotesMode.list);
    }
  }

  void setSearchMode(){
    emit(NotesMode.search);
  }

  void setListMode(){
    emit(NotesMode.list);
  }
}
