import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/about-app/about_app_page.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/square_icon_button.dart';
import 'package:miigaik/features/other-services/other_services_page.dart';
import 'package:miigaik/features/profile/widgets/error_profile_widget.dart';
import 'package:miigaik/features/profile/widgets/guest_profile_widget.dart';
import 'package:miigaik/features/profile/widgets/item_profile_widget.dart';
import 'package:miigaik/features/profile/widgets/loading_profile_widget.dart';
import 'package:miigaik/features/profile/widgets/profile_widget.dart';
import 'package:miigaik/features/settings/settings_page.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

import 'bloc/auth_cubit/auth_cubit.dart';
import 'bloc/profile_bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final authCubit = GetIt.I.get<AuthCubit>();
    final profileBloc = GetIt.I.get<ProfileBloc>();

    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state){
        if (state is AuthorizedState){
          profileBloc.add(GetProfileEvent());
        } else if (state is NotAuthorizedState && profileBloc.state is ProfileLoaded){
          profileBloc.add(ForgetProfileEvent());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              left: horizontalPaddingPage,
              right: horizontalPaddingPage,
              top: 49,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Профиль",
                        style: TS.medium23.use(context.palette.text),
                      ),
                    ),
                    SquareIconButton(
                      size: 40,
                      icon: Icon(
                          I.settings, size: 28, color: context.palette.text),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                    if (state is AuthorizedState)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SquareIconButton(
                          size: 40,
                          icon: Icon(
                              I.logout, size: 28,
                              color: context.palette.text
                          ),
                          onTap: () {
                            authCubit.logout();
                          },
                        ),
                      ),
                  ],
                ),
                20.vs(),
                switch(authCubit.state){
                  NotAuthorizedState() => GuestProfileWidget(
                    onTapLogin: () async {
                      await authCubit.auth("123", "123");
                    },
                  ),
                  LoadingAuthState() => LoadingProfileWidget(),
                  ErrorAuthState(error: var error) => ErrorProfileWidget(error: error),
                  AuthorizedState() => ProfileWidget()
                },
                20.vs(),
                Column(
                  spacing: 10,
                  children: [
                    if (state is AuthorizedState)
                      ItemProfileWidget(
                        title: "Информация о студенте",
                        onTap: (() {}),
                      ),
                    if (state is AuthorizedState)
                      ItemProfileWidget(
                          title: "Успеваемость",
                          onTap: (() {})
                      ),
                    if (state is AuthorizedState)
                      ItemProfileWidget(
                          title: "Учебный план",
                          onTap: (() {})
                      ),
                    ItemProfileWidget(
                        title: "Услуги",
                        onTap: (() {})
                    ),
                    ItemProfileWidget(
                      title: "Другие сервисы",
                      onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtherServicesPage(),
                        ),
                      );
                    })
                    ),
                    ItemProfileWidget(
                      title: "О приложении",
                      onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutAppPage(),
                        ),
                      );
                    })
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
