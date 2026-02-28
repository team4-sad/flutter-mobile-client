import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';

class DeleteDismissible extends StatelessWidget {

  final VoidCallback onDelete;
  final Widget child;

  const DeleteDismissible({super.key, required this.onDelete, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            18.hs()
          ],
        ),
      ),
      key: UniqueKey(),
      child: child,
    );
  }

}