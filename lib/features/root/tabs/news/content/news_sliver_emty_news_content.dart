import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/theme/values.dart';

class NewsSliverEmptyNewsContent extends StatelessWidget {

  const NewsSliverEmptyNewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: heightAreaBottomNavBar
        ),
        child: Center(
          child: PlaceholderWidget.emptyNews(),
        )
      ),
    );
  }
}