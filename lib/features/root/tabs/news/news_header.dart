import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';


class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Поиск...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }
}

class NewsHeader extends StatelessWidget {

  final bool _showDivider;
  final EdgeInsets _contentPadding;

  const NewsHeader({
    super.key,
    required bool showDivider,
    required EdgeInsets contentPadding,
  }):
    _showDivider = showDivider,
    _contentPadding = contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.palette.background,
      padding: _contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Новости', style: TS.medium25.use(context.palette.text)),
              SizedBox(height: 10),
              _SearchField(),
            ],
          ),
          SizedBox(height: 14),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 1,
            color: _showDivider
                ? context.palette.container
                : context.palette.container.withAlpha(0),
          ),
        ],
      ),
    );
  }

}