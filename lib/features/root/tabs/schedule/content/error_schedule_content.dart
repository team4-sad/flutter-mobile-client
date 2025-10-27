import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';

class ErrorScheduleContent extends StatelessWidget {
  final Object? exception;

  const ErrorScheduleContent({super.key, this.exception});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: EdgeInsets.only(bottom: 90),
        child: Center(child: PlaceholderWidget.fromException(exception, (){

        })),
      ),
    );
  }
}
