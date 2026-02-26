import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/widgets/app_shimmer.dart';

class LoadingNotesContent extends StatelessWidget {
  const LoadingNotesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsetsGeometry.only(top: 20),
      itemBuilder: (_, __){
        return AppShimmer(height: 77, width: 1.sw);
      },
      itemCount: 4,
    );
  }
}