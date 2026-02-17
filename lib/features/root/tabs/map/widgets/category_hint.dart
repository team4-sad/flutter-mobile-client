import 'package:flutter/material.dart';
import 'package:miigaik/features/root/tabs/map/models/category_model.dart';
import 'package:miigaik/features/root/tabs/map/models/room_model.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class CategoryHint extends StatelessWidget {
  final CategoryModel category;
  final void Function(RoomModel) onTap;

  const CategoryHint({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            category.name,
            style: TS.medium15.use(context.palette.text),
          ),
        ),
        const SizedBox(height: 12),
        ...category.rooms.map(
          (room) => Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => onTap(room),
              child: Container(
                width: double.infinity,
                padding: EdgeInsetsGeometry.symmetric(vertical: 14, horizontal: 14),
                child: Text(
                  room.label,
                  style: TS.regular15.use(context.palette.text)
                ),
              ),
            ),
          )
        )
      ],
    );
  }
}