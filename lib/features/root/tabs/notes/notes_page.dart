import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/widgets/header.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/notes_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/content/loaded_notes_content.dart';
import 'package:miigaik/features/root/tabs/notes/content/loading_notes_content.dart';
import 'package:miigaik/features/root/tabs/notes/models/note_model.dart';
import 'package:miigaik/features/root/tabs/notes/widgets/add_note_floating_action_button.dart';
import 'package:miigaik/theme/values.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NotesBloc bloc = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh(){
    bloc.add(FetchNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddNoteFloatingActionButton(onTap: (){
        setState(() {
          (bloc.state as NotesLoaded).notes.add(NoteModel(title: "TEST", content: "TEST", dateUpdated: DateTime.now(), attachmentLocalPath: null));
        });
      }),
      body: Padding(
        padding: EdgeInsets.only(
          left:  horizontalPaddingPage,
          right: horizontalPaddingPage,
          top: paddingTopPage
        ),
        child: Column(
          children: [
            Header(
              title: "Заметки",
              hint: "Поиск заметок",
              textController: TextEditingController(),
              showDivider: false,
              onChangeText: (text){},
              contentPadding: EdgeInsets.zero,
              showTitle: true,
              showBack: false,
              showClear: false,
              onClearTap: (){},
            ),
            BlocBuilder<NotesBloc, NotesState>(
              bloc: bloc,
              builder: (context, state){
                switch(state){
                  case NotesInitial():
                  case NotesLoading():
                    return LoadingNotesContent();
                  case NotesLoaded():
                    return LoadedNotesContent(notes: state.notes);
                  case NotesError():
                    return Center(
                      child: PlaceholderWidget.somethingWentWrong(
                        onButtonPress: refresh
                      ),
                    );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}