import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
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
    this.controller,
  });

  static double maxSize = 0.83;
  static double minSize = 0.3;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: maxSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      snap: true,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: context.palette.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPaddingPage,
              ),
              child: CustomScrollView(
                controller: controller,
                slivers: [
                  12.svs(),
                  UnconstrainedBox(
                    child: Container(
                      width: 80.w,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.palette.subText
                      ),
                    ),
                  ).s(),
                  18.svs(),
                  SliverPadding(
                    padding: EdgeInsetsGeometry.only(bottom: 30),
                    sliver: Text(title, style: TS.medium20).s(),
                  ),
                  child,
                ],
              ),
            ),
          ),
        ).e();
      },
    );
  }
}
