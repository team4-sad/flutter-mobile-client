import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/common/features/bottom-nav-bar/items_nav_bar.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc(ItemNavBar defaultItem) : super(BottomNavBarState(currentItem: defaultItem)) {
    on<GoToEventEvent>((event, emit) {
      if (event.itemNavBar == state.currentItem){
        return;
      }
      emit(BottomNavBarState(currentItem: event.itemNavBar));
    });
  }
}
