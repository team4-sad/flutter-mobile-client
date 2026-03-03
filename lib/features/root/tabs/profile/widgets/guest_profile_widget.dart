import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class GuestProfileWidget extends StatelessWidget {

  final VoidCallback onTapLogin;

  const GuestProfileWidget({super.key, required this.onTapLogin});

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