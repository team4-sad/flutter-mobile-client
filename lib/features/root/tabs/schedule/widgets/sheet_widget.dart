import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/sliver_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class SheetWidget extends StatelessWidget {
  final DraggableScrollableController? controller;
  final String title;
  final Widget child;

  const SheetWidget({
    super.key, 
    required this.title, 
    required this.child,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0.8,
      minChildSize: 233.h / 1.sh,
      maxChildSize: 0.8,
      snap: true,
      builder: (context, controller) {
        return Column(
          spacing: 4,
          children: [
            Container(
              width: 80.w,
              height: 4,
              decoration: BoxDecoration(
                color: context.palette.background,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.palette.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPaddingPage,
                  ),
                  child: CustomScrollView(
                    controller: controller,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 30),
                        sliver: Text(title, style: TS.medium20).s(),
                      ),
                      child,
                    ],
                  ),
                ),
              ),
            ).e(),
          ],
        );
      },
    );
  }
}
