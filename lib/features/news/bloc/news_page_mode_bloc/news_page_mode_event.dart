part of 'news_page_mode_bloc.dart';

abstract class NewsPageModeEvent {}

final class ChangeMode extends NewsPageModeEvent {
  final NewsPageMode newMode;

  ChangeMode({required this.newMode});
}
