import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class SingleNewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SingleNewsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.palette.background,
      surfaceTintColor: context.palette.background,
      leadingWidth: 70,
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(I.back, color: context.palette.subText,),
      ),
    );
  }

  @override
  Size get preferredSize => Size(1.sw, kToolbarHeight);
}