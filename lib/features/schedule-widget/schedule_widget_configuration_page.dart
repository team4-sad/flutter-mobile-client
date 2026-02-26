import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/content/error_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/content/loading_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/widgets/choose_schedule_widget.dart';
import 'package:miigaik/features/schedule-widget/helpers/home_widget_channel_helper.dart';
import 'package:miigaik/features/schedule-widget/use_case/prepare_widget_use_case.dart';
import 'package:miigaik/theme/values.dart';

import 'helpers/home_widget_helper.dart';
import 'helpers/home_widget_work_manager_helper.dart';

class ScheduleWidgetConfigurationPage extends StatefulWidget {
  final int widgetId;

  const ScheduleWidgetConfigurationPage({super.key, required this.widgetId});

  @override
  State<ScheduleWidgetConfigurationPage> createState() => _ScheduleWidgetConfigurationPageState();
}

class _ScheduleWidgetConfigurationPageState extends State<ScheduleWidgetConfigurationPage> {
  final SignatureScheduleBloc bloc = GetIt.I.get();
  final saveUseCase = PrepareWidgetUseCase();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchSignaturesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Выбор расписания",
        onBackPress: () async {
          await cancel(context);
        }
      ),
      body: Padding(
        padding: horizontalPaddingPage.horizontal(),
        child: Stack(
          children: [
            BlocBuilder<SignatureScheduleBloc, SignatureScheduleState>(
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
                        await save(signature, context.locale);
                      },
                    );
                }
              },
            ),
            if (_isSaving) _buildSavingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildSavingOverlay() {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Загрузка расписания...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Это займет несколько секунд",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> save(SignatureScheduleModel signature, Locale locale) async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final success = await saveUseCase.call(
          widget.widgetId, signature, DateTime.now(), locale.toString()
      );

      if (success) {
        debugPrint("Расписание успешно загружено сразу");
        await HomeWidgetHelper.update();
      } else {
        debugPrint("Запущена фоновая загрузка расписания");
        await HomeWidgetWorkManagerHelper.startBackgroundScheduleLoad(
            widget.widgetId, signature, locale
        );
        await HomeWidgetHelper.update();
      }

      await HomeWidgetWorkManagerHelper.setupDailyUpdates(
          widget.widgetId, signature, locale
      );

      await HomeWidgetChannelHelper.finish();
    } catch (e) {
      debugPrint("Error saving widget: $e");
      await HomeWidgetChannelHelper.finish();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> cancel(BuildContext context) async {
    if (_isSaving) return;

    try {
      await HomeWidgetChannelHelper.cancel();
    } catch (e) {
      debugPrint("Error canceling configuration: $e");
      if (context.mounted){
        Navigator.of(context).pop();
      }
    }
  }
}