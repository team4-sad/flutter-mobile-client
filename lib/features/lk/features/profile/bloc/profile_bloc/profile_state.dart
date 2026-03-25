part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded({required this.profile});
}

final class ProfileError extends WithErrorState implements ProfileState {
  ProfileError({required super.error});
}
