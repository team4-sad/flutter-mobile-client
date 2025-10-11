import 'package:flutter/material.dart';
import 'package:miigaik/theme/text_styles.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Скоро тут что-то будет 😉", style: TS.medium25),
      ),
    );
  }
}