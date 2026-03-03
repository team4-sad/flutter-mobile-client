import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/with_error_state.dart';
import 'package:miigaik/features/root/tabs/profile/models/profile_model.dart';
import 'package:miigaik/features/root/tabs/profile/use_case/get_profile_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final getProfileUseCase = GetProfileUseCase(repository: GetIt.I.get());

  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoading());
        final profile = await getProfileUseCase();
        emit(ProfileLoaded(profile));
      } on Object catch(e){
        emit(ProfileError(error: e));
      }
    });

    on<ForgetProfileEvent>((event, emit) async {
      emit(ProfileInitial());
    });
  }
}
