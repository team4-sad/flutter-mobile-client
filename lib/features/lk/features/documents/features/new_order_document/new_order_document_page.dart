import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/sliver_widget_extension.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/documents/features/new_order_document/widgets/select_document_type_widget.dart';
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
            SelectDocumentTypeWidget().s()
          ],
        ),
      ),
    );
  }
}