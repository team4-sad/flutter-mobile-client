import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/add-schedule/add_schedule_page.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/content/error_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/content/loaded_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/content/loading_schedule_choose_content.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/values.dart';

class ScheduleChoosePage extends StatelessWidget {
  ScheduleChoosePage({super.key});

  final SignatureScheduleBloc bloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    bloc.add(FetchSignaturesEvent());
    return Scaffold(
      appBar: SimpleAppBar(title: "Выбор расписания"),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddSchedulePage()),
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: context.palette.lightText,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(I.plus, color: context.palette.unAccent, size: 36),
          ),
        ),
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
                return LoadedScheduleChooseContent(
                  data: state.data,
                  selected: state.selected
                );
            }
          },
        ),
      ),
    );
  }
}
