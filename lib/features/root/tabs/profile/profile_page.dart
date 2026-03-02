import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/about-app/about_app_page.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/square_icon_button.dart';
import 'package:miigaik/features/edini-dekanat/edini_dekanat_page.dart';
import 'package:miigaik/features/other-services/other_services_page.dart';
import 'package:miigaik/features/root/tabs/profile/widgets/item_profile_widget.dart';
import 'package:miigaik/features/root/tabs/profile/widgets/profile_widget.dart';
import 'package:miigaik/features/settings/settings_page.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              spacing: 10,
              children: [
                Expanded(
                  child: Text(
                    "Профиль",
                    style: TS.medium25.use(context.palette.text),
                  ),
                ),
                SquareIconButton(
                  size: 40,
                  icon: Icon(I.addNotification, size: 28, color: context.palette.text),
                  onTap: () {},
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
              ],
            ),
            20.vs(),
            ProfileWidget(),
            20.vs(),
            ItemProfileWidget(
              title: "Заказ допусков",
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EdiniDekanatPage.dopuski(),
                  ),
                );
              }),
            ),
            10.vs(),
            ItemProfileWidget(title: "Заказ справок", onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EdiniDekanatPage.spravki(),
                  ),
                );
            })),
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
