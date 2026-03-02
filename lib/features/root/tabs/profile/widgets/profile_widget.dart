import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/root/tabs/profile/bloc/auth_cubit/auth_cubit.dart';
import 'package:miigaik/features/root/tabs/profile/bloc/profile_bloc/profile_bloc.dart';
import 'package:miigaik/features/root/tabs/profile/models/profile_model.dart';
import 'package:miigaik/features/root/tabs/profile/widgets/loading_profile_widget.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({super.key});

  final authCubit = GetIt.I.get<AuthCubit>();
  final profileBloc = GetIt.I.get<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    if (authCubit.state is AuthorizedState){
      profileBloc.add(GetProfileEvent());
    }
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state){
        if (state is AuthorizedState){
          profileBloc.add(GetProfileEvent());
        }
      },
      builder: (context, state) {
        switch (state) {
          case AuthorizedState():
            return BlocBuilder<ProfileBloc, ProfileState>(
              bloc: GetIt.I.get(),
              builder: (context, state){
                switch (state) {
                  case ProfileInitial():
                  case ProfileLoading():
                    return LoadingProfileWidget();
                  case ProfileError(error: var error):
                    return PlaceholderWidget.fromException(error);
                  case ProfileLoaded(profile: var profile):
                    return _UserProfileWidget(profile: profile);
                }
              }
            );
          case NotAuthorizedState():
            return _GuestProfileWidget(
              onTapLogin: () async {
                await authCubit.auth("123", "123");
              },
            );
          case LoadingAuthState():
            return LoadingProfileWidget();
          case ErrorAuthState(error: var error):
            return PlaceholderWidget.fromException(error);
        }
      },
    );
  }
}

class _GuestProfileWidget extends StatelessWidget {

  final VoidCallback onTapLogin;

  const _GuestProfileWidget({required this.onTapLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.hs(),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/default_avatar.png")
            ),
            20.hs(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.vs(),
                  Text("Войдите в аккаунт", style: TS.medium18.use(context.palette.text)),
                  8.vs(),
                  Text(
                    "Чтобы получить доступ к расписанию, учебному плану и другим функциям",
                    style: TS.regular12.use(context.palette.text),
                  )
                ],
              ),
            ),
            10.hs(),
          ],
        ),
        10.vs(),
        FilledButton(
          onPressed: onTapLogin,
          child: Text("Войти", style: TS.medium15,)
        ).fillW(height: 46)
      ],
    );
  }
}

class _UserProfileWidget extends StatelessWidget {

  final ProfileModel profile;

  const _UserProfileWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.hs(),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/default_avatar.png")
            ),
            20.hs(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.vs(),
                  Text(profile.fullFIO(), style: TS.medium18.use(context.palette.text)),
                  8.vs(),
                  Text(
                    profile.lkEmail,
                    style: TS.regular12.use(context.palette.text),
                  ),
                  5.vs(),
                  Text(
                    profile.educationInfo.lastOrNull?.group ?? "Неизвестная группа",
                    style: TS.regular12.use(context.palette.text),
                  ),
                  5.vs(),
                  Text(
                    "${profile.educationInfo.lastOrNull?.course ?? "Неизвестный"} курс",
                    style: TS.regular12.use(context.palette.text),
                  ),
                ],
              ),
            ),
            10.hs(),
          ],
        ),
      ],
    );
  }
}