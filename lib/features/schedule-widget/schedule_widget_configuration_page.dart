import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_widget/home_widget.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/content/error_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/content/loading_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/widgets/choose_schedule_widget.dart';
import 'package:miigaik/theme/values.dart';

class ScheduleWidgetConfigurationPage extends StatelessWidget {

  final int widgetId;

  ScheduleWidgetConfigurationPage({super.key, required this.widgetId});

  final SignatureScheduleBloc bloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    bloc.add(FetchSignaturesEvent());
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Выбор расписания",
        onBackPress: (){cancel(context);}
      ),
      body: Padding(
        padding: horizontalPaddingPage.horizontal(),
        child: BlocBuilder<SignatureScheduleBloc, SignatureScheduleState>(
          bloc: bloc,
          builder: (context, state) {
            switch (state) {
              case SignatureScheduleLoading():
              case SignatureScheduleInitial():
                return LoadingScheduleChooseContent();
              case SignatureScheduleError():
                return ErrorScheduleChooseContent(
                    error: state.error
                );
              case SignatureScheduleLoaded():
                return ChooseScheduleWidget(
                  data: state.data,
                  emptyTitle: "Расписаний нет",
                  emptySubTitle: "Добавьте расписание в приложении",
                  onChoose: (signature) async {
                    await save(signature);
                  }
                );
            }
          },
        ),
      ),
    );
  }

  Future<void> save(SignatureScheduleModel model) async {
    try {
      await HomeWidget.saveWidgetData(
        '${widgetId}_group_title',
        model.title,
      );
      await HomeWidget.saveWidgetData(
        '${widgetId}_group_type',
        model.type.display,
      );
      await HomeWidget.saveWidgetData(
        '${widgetId}_group_id',
        model.id,
      );

      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');

      await MethodChannel("widget_config").invokeMethod("finish");
    } catch (e) {
      debugPrint("Error saving widget: $e");
      await MethodChannel("widget_config").invokeMethod("finish");
    }
  }

  Future<void> cancel(BuildContext context) async {
    try {
      await MethodChannel("widget_config").invokeMethod("cancel");
    } catch (e) {
      debugPrint("Error canceling configuration: $e");
      // Если метод не работает, просто выходим
      if (context.mounted){
        Navigator.of(context).pop();
      }
    }
  }
}