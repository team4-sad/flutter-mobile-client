import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/profile/bloc/auth_cubit/auth_cubit.dart';
import 'package:miigaik/features/root/tabs/profile/bloc/profile_bloc/profile_bloc.dart';
import 'package:miigaik/features/root/tabs/profile/models/profile_model.dart';
import 'package:miigaik/features/root/tabs/profile/widgets/error_profile_widget.dart';
import 'package:miigaik/features/root/tabs/profile/widgets/loading_profile_widget.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = GetIt.I.get<AuthCubit>();
    final profileBloc = GetIt.I.get<ProfileBloc>();

    if (authCubit.state is AuthorizedState) {
      profileBloc.add(GetProfileEvent());
    }

    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      builder: (context, state) {
        switch(state){
          case ProfileInitial():
          case ProfileLoading():
            return LoadingProfileWidget();
          case ProfileError(error: var error):
            return ErrorProfileWidget(error: error);
          case ProfileLoaded(profile: var profile):
            return _ProfileWidget(profile: profile);
        }
      },
    );
  }
}

class _ProfileWidget extends StatelessWidget {

  final ProfileModel profile;

  const _ProfileWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.hs(),
            ClipOval(
              child: SvgPicture.asset("assets/vectors/default_avatar.svg"),
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