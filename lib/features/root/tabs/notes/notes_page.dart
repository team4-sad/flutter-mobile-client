import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/header.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(
            title: "Заметки",
            hint: "Поиск заметок",
            textController: TextEditingController(),
            showDivider: false,
            onChangeText: (text){},
            showTitle: true,
            showBack: false,
            showClear: false,
            onClearTap: (){},
          ),
        ],
      ),
    );
  }

}