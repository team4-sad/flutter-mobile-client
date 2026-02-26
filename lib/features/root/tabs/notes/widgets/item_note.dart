import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/delete_dismissible.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemNote extends StatelessWidget {

  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ItemNote({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.palette.container,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: DeleteDismissible(
                  key: ValueKey<int>(note.hashCode),
                  onDelete: onDelete,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: TS.medium15.use(context.palette.text),
                        ),
                        5.vs(),
                        Text(
                          note.content,
                          style: TS.light12.use(context.palette.text),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}