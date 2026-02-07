import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/common/widgets/header.dart';
import 'package:miigaik/features/common/widgets/on_bottom_scroll_widget.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/note/note_page.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/notes_bloc/notes_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/notes_mode_cubit/notes_mode_cubit.dart';
import 'package:miigaik/features/root/tabs/notes/bloc/search_notes_bloc/search_notes_bloc.dart';
import 'package:miigaik/features/root/tabs/notes/content/loaded_notes_content.dart';
import 'package:miigaik/features/root/tabs/notes/content/loading_notes_content.dart';
import 'package:miigaik/features/root/tabs/notes/enum/notes_mode.dart';
import 'package:miigaik/features/root/tabs/notes/widgets/add_note_floating_action_button.dart';
import 'package:miigaik/theme/values.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NotesBloc notesBloc = GetIt.I.get();
  final NotesModeCubit notesModeCubit = GetIt.I.get();
  final SearchNotesBloc searchNotesBloc = GetIt.I.get();
  final TextEditingController searchTextController = TextEditingController();

  bool showDivider = false;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() {
    notesBloc.add(FetchNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddNoteFloatingActionButton(onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotePage()));
      }),
      body: Padding(
        padding: EdgeInsets.only(
          top: paddingTopPage
        ),
        child: Column(
          children: [
            Header(
              title: "Заметки",
              hint: "Поиск заметок",
              textController: searchTextController,
              showDivider: showDivider,
              onChangeText: (text) {
                if (text.isEmpty){
                  notesModeCubit.setListMode();
                } else {
                  notesModeCubit.setSearchMode();
                  searchNotesBloc.add(SearchNotesTextChangedEvent(text: text));
                }
              },
              contentPadding: EdgeInsets.symmetric(
                horizontal: horizontalPaddingPage
              ),
              showTitle: true,
              showBack: false,
              showClear: notesModeCubit.state == NotesMode.search,
              onClearTap: () {
                notesModeCubit.setListMode();
                searchNotesBloc.add(ClearSearchNotesEvent());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPaddingPage
              ),
              child: OnScrollWidget(
                onTop: (){
                  setState(() {
                    showDivider = false;
                  });
                },
                onNotTop: (){
                  setState(() {
                    showDivider = true;
                  });
                },
                child: BlocBuilder<NotesModeCubit, NotesMode>(
                  bloc: notesModeCubit,
                  builder: (context, state) {
                    if (state == NotesMode.list) {
                      return BlocBuilder<NotesBloc, NotesState>(
                        bloc: notesBloc,
                        builder: (context, state) {
                          switch (state) {
                            case NotesInitial():
                            case NotesLoading():
                              return LoadingNotesContent();
                            case NotesLoaded():
                              return LoadedNotesContent(notes: state.notes);
                            case NotesError():
                              return Center(
                                child: PlaceholderWidget.fromException(
                                  state.object, fetch
                                ),
                              );
                          }
                        }
                      );
                    } else {
                      return BlocBuilder<SearchNotesBloc, SearchNotesState>(
                        bloc: searchNotesBloc,
                        builder: (context, state){
                          return switch(state) {
                            SearchNotesInitial() => Expanded(
                              child: Center(
                                child: PlaceholderWidget(
                                  title: "Введите текст для поиска заметок"
                                ),
                              ),
                            ),
                            SearchNotesLoadingState() => LoadingNotesContent(),
                            SearchNotesLoadedState() => LoadedNotesContent(
                              notes: state.data ?? []
                            ),
                            SearchNotesErrorState() => Center(
                              child: PlaceholderWidget.fromException(
                                state.error, fetch
                              )
                            )
                          };
                        }
                      );
                    }
                  },
                ),
              ),
            ).e(),
          ],
        ),
      ),
    );
  }
}