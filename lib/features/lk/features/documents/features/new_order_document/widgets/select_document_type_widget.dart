import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/app_shimmer.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/features/lk/features/documents/features/new_order_document/bloc/document_forms_cubit/document_forms_cubit.dart';
import 'package:miigaik/features/lk/features/documents/features/new_order_document/widgets/options_field_widget.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class SelectDocumentTypeWidget extends StatelessWidget {
  const SelectDocumentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentFormsCubit, DocumentFormsState>(
      builder: (context, state) {
        return switch(state){
          DocumentFormsInitial() => AppShimmer.container(height: 74),
          DocumentFormsLoading() => AppShimmer.container(height: 74),
          DocumentFormsError(error: var err) => Center(
            child: PlaceholderWidget.fromException(err),
          ),
          DocumentFormsLoaded(data: var documentsForms) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OptionsFieldWidget(
                label: "Тип документа",
                hint: "Выберите тип документа",
                options: documentsForms.map((e) => e.name).toList()
              ),
              8.vs(),
              Text(
                "Справка о неоконченном высшем образовании с оценками (для перевода в другой ВУЗ или восстановления)",
                style: TS.regular12.use(context.palette.subText),
              )
            ],
          )
        };
      },
    );
  }

}