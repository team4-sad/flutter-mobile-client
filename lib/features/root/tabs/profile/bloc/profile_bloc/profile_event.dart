part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class GetProfileEvent extends ProfileEvent {}
final class ForgetProfileEvent extends ProfileEvent {}
