part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarEvent {}

class GoToEventEvent extends BottomNavBarEvent {
  final ItemNavBar itemNavBar;

  GoToEventEvent(this.itemNavBar);
}