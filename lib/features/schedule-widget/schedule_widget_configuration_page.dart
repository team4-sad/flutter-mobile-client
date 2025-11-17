import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_widget/home_widget.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/root/tabs/schedule/repository/schedule_repository.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/content/error_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/content/loading_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/widgets/choose_schedule_widget.dart';
import 'package:miigaik/theme/values.dart';

class ScheduleWidgetConfigurationPage extends StatefulWidget {

  final int widgetId;

  const ScheduleWidgetConfigurationPage({super.key, required this.widgetId});

  @override
  State<ScheduleWidgetConfigurationPage> createState() => _ScheduleWidgetConfigurationPageState();
}

class _ScheduleWidgetConfigurationPageState extends State<ScheduleWidgetConfigurationPage> {
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
        '${widget.widgetId}_schedule_title',
        model.title,
      );
      await HomeWidget.saveWidgetData(
        '${widget.widgetId}_schedule_type',
        model.type.display,
      );
      await HomeWidget.saveWidgetData(
        '${widget.widgetId}_schedule_id',
        model.id,
      );
      final date = DateTime(2025, 11, 20);
      final quickSchedule = await _tryQuickScheduleLoad(model.id, date);
      if (quickSchedule != null) {
        await _saveSchedule(quickSchedule, date.yyyyMMdd);
      } else {
        await HomeWidget.saveWidgetData(
          '${widget.widgetId}_schedule_state',
          'loading',
        );
        // await _startBackgroundScheduleLoad();
      }

      await HomeWidget.updateWidget(name: 'ScheduleAppWidget');

      await MethodChannel("widget_config").invokeMethod("finish");
    } catch (e) {
      debugPrint("Error saving widget: $e");
      await MethodChannel("widget_config").invokeMethod("finish");
    }
  }

  Future<void> _saveSchedule(List<LessonModel> data, String date) async {
    await HomeWidget.saveWidgetData(
      '${widget.widgetId}_schedule_size',
      data.length,
    );
    await HomeWidget.saveWidgetData(
      '${widget.widgetId}_schedule_date',
      date,
    );
    for (int i=0; i<data.length; i++){
      final lesson = data[i];
      await HomeWidget.saveWidgetData(
        '${widget.widgetId}_lessons_${i}_title',
        lesson.disciplineName,
      );
      await HomeWidget.saveWidgetData(
        '${widget.widgetId}_lessons_${i}_start_time',
        lesson.displayStartTime,
      );
      await HomeWidget.saveWidgetData(
        '${widget.widgetId}_lessons_${i}_end_time',
        lesson.displayEndTime,
      );
      await HomeWidget.saveWidgetData(
        '${widget.widgetId}_lessons_${i}_number',
        lesson.lessonOrderNumber,
      );
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

  final IScheduleRepository repository = GetIt.I.get();

  Future<List<LessonModel>?> _tryQuickScheduleLoad(String groupId, DateTime date) async {
    try {
      final response = await repository.fetchDayGroupSchedule(
          groupId: groupId,
          day: date
      );
      // .timeout(Duration(seconds: 1));
      List<LessonModel> data = [];
      if (response.schedule.isNotEmpty){
        data = response.schedule.first.lessons;
      }
      return data;
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }
}