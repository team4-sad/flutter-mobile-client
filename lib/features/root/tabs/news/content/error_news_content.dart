import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/theme/values.dart';

class ErrorNewsContent extends StatelessWidget {

  final Object _exception;
  final VoidCallback _onTapRetry;

  const ErrorNewsContent({
    super.key,
    required Object exception,
    required void Function() onTapRetry
  }) : _exception = exception, _onTapRetry = onTapRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: heightAreaBottomNavBar
      ),
      child: Center(
        child: PlaceholderWidget.fromException(
          _exception,
          _onTapRetry,
        )
      )
    );
  }
}