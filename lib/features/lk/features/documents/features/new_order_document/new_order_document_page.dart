import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/sliver_widget_extension.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/documents/features/new_order_document/widgets/options_field_widget.dart';
import 'package:miigaik/theme/values.dart';

class NewOrderDocumentPage extends StatelessWidget {
  const NewOrderDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Заказ документа",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: CustomScrollView(
          slivers: [
            OptionsFieldWidget(
              label: "Тип документа",
              hint: "Выберите тип документа",
              options: [
                "TEST1",
                "TEST2",
                "TEST3",
                "TEST4",
                "TEST5",
                "TEST6",
                "TEST7",
                "TEST8",
                "TEST9",
              ],
            ).s()
          ],
        ),
      ),
    );
  }
}