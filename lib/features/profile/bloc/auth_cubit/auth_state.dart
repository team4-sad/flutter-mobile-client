part of 'auth_cubit.dart';

sealed class AuthState {}

final class NotAuthorizedState extends AuthState {}

final class FailAuthorizedState extends NotAuthorizedState {}

final class LoadingAuthState extends AuthState {}

final class ErrorAuthState extends WithErrorState implements AuthState{
  ErrorAuthState({required super.error});
}

final class AuthorizedState extends AuthState with EquatableMixin {
  final SessionModel session;

  AuthorizedState({required this.session});

  @override
  List<Object?> get props => [session];
}
