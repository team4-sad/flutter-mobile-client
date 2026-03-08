import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/bloc/selecting_schedule_choose_page_cubit/selecting_schedule_choose_page_cubit.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/bloc/signature_schedule_bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/content/loaded_schedule_choose_content.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/widgets/choose_new_signature_floating_action_button.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/widgets/delete_floating_action_button.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/widgets/selection_app_bar.dart';
import 'package:miigaik/theme/values.dart';

import 'content/error_schedule_choose_content.dart';
import 'content/loading_schedule_choose_content.dart';

class ScheduleChoosePage extends StatelessWidget {
  ScheduleChoosePage({super.key});

  final SignatureScheduleBloc signatureBloc = GetIt.I.get();
  final SelectingScheduleChoosePageCubit selectingCubit = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    signatureBloc.add(FetchSignaturesEvent());
    return Scaffold(
      appBar: _AppBar(),
      floatingActionButton: BlocBuilder<SelectingScheduleChoosePageCubit,
          List<SignatureScheduleModel>?>(
        bloc: selectingCubit,
        builder: (context, state) {
          if (!selectingCubit.isSelectionMode) {
            return ChooseNewSignatureFloatingActionButton();
          } else {
            return DeleteFloatingActionButton(onDelete: () {
              if (state != null){
                signatureBloc.add(ManyRemoveSignatureEvent(deleteSignatures: state));
              }
              selectingCubit.disableSelectionMode();
            });
          }
        },
      ),
      body: Padding(
        padding: horizontalPaddingPage.horizontal(),
        child: BlocBuilder<SignatureScheduleBloc, SignatureScheduleState>(
          bloc: signatureBloc,
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

class _AppBar extends StatelessWidget implements PreferredSizeWidget {

  final SelectingScheduleChoosePageCubit cubit = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectingScheduleChoosePageCubit,
        List<SignatureScheduleModel>?>(
      bloc: cubit,
      builder: (BuildContext context, List<SignatureScheduleModel>? state) {
        if (!cubit.isSelectionMode) {
          return SimpleAppBar(
            title: "Выбор расписания",
            onBackPress: (){
              Navigator.pop(context);
            },
          );
        } else {
          return SelectionAppBar(
            onBackPress: (){
              cubit.disableSelectionMode();
            },
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}