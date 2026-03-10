import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miigaik/core/extensions/date_time_extensions.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/core/widgets/square_icon_button.dart';
import 'package:miigaik/features/notes/features/note/use_case/add_attachment_use_case.dart';
import 'package:miigaik/features/notes/features/note/use_case/delete_attachment_use_case.dart';
import 'package:miigaik/features/notes/features/note/use_case/is_already_note_saved_use_case.dart';
import 'package:miigaik/features/notes/features/note/use_case/save_note_use_case.dart';
import 'package:miigaik/features/notes/features/note/widgets/image_attachment.dart';
import 'package:miigaik/features/notes/models/note_model.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class NotePage extends StatefulWidget {

  final NoteModel note;

  NotePage({super.key, NoteModel? note}): note = note ?? NoteModel.empty();

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final title = TextEditingController();
  final content = TextEditingController();

  final saveUseCase = SaveNoteUseCase();
  final isAlreadySavedUseCase = IsAlreadyNoteSavedUseCase();
  final addAttachmentUseCase = AddAttachmentUseCase();
  final deleteAttachmentUseCase = DeleteAttachmentUseCase();

  @override
  void initState() {
    super.initState();
    title.text = widget.note.title;
    content.text = widget.note.content;
    if (!isAlreadySavedUseCase.isAlreadySaved(widget.note)){
      saveUseCase.save(widget.note);
    }
  }

  void onChange(_){
    widget.note.title = title.text;
    widget.note.content = content.text;
    widget.note.dateUpdated = DateTime.now();
    saveUseCase.save(widget.note);
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await addAttachmentUseCase.addAttachment(imageFile, widget.note);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        action: [
          SquareIconButton(
            size: 40,
            icon: Icon(I.attachment, color: context.palette.text),
            onTap: _pickImageFromGallery
          ),
          SquareIconButton(
            size: 40,
            icon: Icon(I.addNotification, color: context.palette.text),
            onTap: (){

            }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: title,
                      style: TS.medium18.use(context.palette.text),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: onChange,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "Название заметки",
                        hintStyle: TS.medium18.use(context.palette.subText),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    if (widget.note.file != null)
                      ImageAttachment(
                        attachment: widget.note.file!,
                        onTapDelete: () async {
                          await deleteAttachmentUseCase.removeAttachment(widget.note);
                          setState(() {});
                        }
                      ),
                    15.vs(),
                    TextField(
                      controller: content,
                      style: TS.regular13.use(context.palette.text),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: onChange,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "Текст",
                        hintStyle: TS.regular13.use(context.palette.subText),
                        contentPadding: EdgeInsets.zero
                      ),
                    ),
                  ],
                ),
              ),
            ),
            15.vs(),
            Text(
              "Последнее изменение: ${DateTime.now().ddMMyy}",
              style: TS.light12.use(context.palette.subText),
            ),
            36.vs()
          ],
        ),
      ),
    );
  }
}