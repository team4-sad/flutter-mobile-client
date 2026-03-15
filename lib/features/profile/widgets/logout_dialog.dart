import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class LogoutDialog extends StatelessWidget {

  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  static void show(BuildContext context, VoidCallback onLogout){
    showDialog(context: context, builder: (context) => LogoutDialog(onLogout: onLogout));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: Container(
          width: 1.sw,
          padding: EdgeInsets.only(
            top: 22,
            left: 22,
            right: 16,
            bottom: 8
          ),
          decoration: BoxDecoration(
            color: context.palette.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Выход", style: TS.medium20.use(context.palette.text)),
              10.vs(),
              Text(
                "Вы уверенны, что хотите выйти из аккаунта личного кабинета?",
                style: TS.regular15.use(context.palette.text),
              ),
              18.vs(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Отмена", style: TS.medium15.use(context.palette.text))
                  ),
                  8.hs(),
                  TextButton(
                    onPressed: (){
                      onLogout();
                      Navigator.pop(context);
                    },
                    child: Text("Выйти", style: TS.medium15.use(context.palette.accent))
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}