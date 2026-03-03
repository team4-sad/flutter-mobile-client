import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/about-app/about_app_page.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/square_icon_button.dart';
import 'package:miigaik/features/other-services/other_services_page.dart';
import 'package:miigaik/features/root/tabs/profile/widgets/item_profile_widget.dart';
import 'package:miigaik/features/root/tabs/profile/widgets/profile_widget.dart';
import 'package:miigaik/features/settings/settings_page.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

import 'bloc/auth_cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = GetIt.I.get<AuthCubit>();
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
                    style: TS.medium25.use(context.palette.text),
                  ),
                ),
                SquareIconButton(
                  size: 40,
                  icon: Icon(I.settings, size: 28, color: context.palette.text),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: authCubit,
                  builder: (context, state) {
                    if (state is AuthorizedState){
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SquareIconButton(
                          size: 40,
                          icon: Icon(
                            I.logout, size: 28, color: context.palette.text
                          ),
                          onTap: () {
                            authCubit.logout();
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
            20.vs(),
            ProfileWidget(),
            20.vs(),
            ItemProfileWidget(
              title: "Информация о студенте",
              onTap: (() {}),
            ),
            10.vs(),
            ItemProfileWidget(
              title: "Успеваемость",
              onTap: (() {})
            ),
            10.vs(),
            ItemProfileWidget(
              title: "Учебный план",
              onTap: (() {})
            ),
            10.vs(),
            ItemProfileWidget(
              title: "Услуги",
              onTap: (() {})
            ),
            10.vs(),
            ItemProfileWidget(title: "Другие сервисы", onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherServicesPage(),
                ),
              );
            })),
            10.vs(),
            ItemProfileWidget(title: "О приложении", onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutAppPage(),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}
