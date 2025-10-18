import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/theme/values.dart';

class EmptyNewsContent extends StatelessWidget {

  const EmptyNewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: heightAreaBottomNavBar
      ),
      child: Center(
        child: PlaceholderWidget.emptyNews(),
      )
    );
  }
}