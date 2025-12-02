import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/note/note_page.dart';
import 'package:miigaik/features/root/tabs/notes/content/empty_notes_content.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/widgets/item_note.dart';

class LoadedNotesContent extends StatelessWidget {

  final List<NoteModel> notes;

  const LoadedNotesContent({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (notes.isNotEmpty)
        ? ListView.separated(
            padding: EdgeInsets.only(bottom: 190),
            itemBuilder: (context, index){
              final note = notes[index];
              return ItemNote(note: note, onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NotePage(note: note)
                  )
                );
              });
            },
            separatorBuilder: (_, __) => 10.vs(),
            itemCount: notes.length
          )
        : EmptyNotesContent()
    );
  }

}