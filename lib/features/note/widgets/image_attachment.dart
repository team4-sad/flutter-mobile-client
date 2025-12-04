import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/image_dialog.dart';
import 'package:miigaik/features/common/widgets/square_icon_button.dart';

class ImageAttachment extends StatelessWidget {

  final File attachment;
  final VoidCallback onTapDelete;

  const ImageAttachment({super.key, required this.attachment, required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: (){
          showFileImageDialog(context, attachment);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(children: [
            Image.file(attachment),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: SquareIconButton(
                  size: 40,
                  icon: Icon(Icons.delete),
                  onTap: onTapDelete
                ),
              ),
            ),
          ])
        ),
      ),
    );
  }
}