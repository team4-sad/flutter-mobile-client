import 'dart:async';

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
import 'package:miigaik/features/schedule-widget/use_case/save_configuration_use_case.dart';
import 'package:miigaik/theme/values.dart';

import 'helpers/home_widget_helper.dart';

class ScheduleWidgetConfigurationPage extends StatefulWidget {

  final int widgetId;

  const ScheduleWidgetConfigurationPage({super.key, required this.widgetId});

  @override
  State<ScheduleWidgetConfigurationPage> createState() => _ScheduleWidgetConfigurationPageState();
}

class _ScheduleWidgetConfigurationPageState extends State<ScheduleWidgetConfigurationPage> {
  final SignatureScheduleBloc bloc = GetIt.I.get();
  final saveUseCase = SaveConfigurationUseCase();

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

  Future<void> save(SignatureScheduleModel signature) async {
    try {
      await saveUseCase.call(widget.widgetId, signature, DateTime.now());
      await HomeWidgetHelper.update();
      await HomeWidgetChannelHelper.finish();
    } catch (e) {
      debugPrint("Error saving widget: $e");
      await HomeWidgetChannelHelper.finish();
    }
  }

  Future<void> cancel(BuildContext context) async {
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

