import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc/signature_schedule_bloc.dart';

class ErrorScheduleChooseContent extends StatelessWidget {
  final Object error;

  ErrorScheduleChooseContent({super.key, required this.error});

  final SignatureScheduleBloc bloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {

    return Center(
      child: PlaceholderWidget.fromException(
        error, () {
          bloc.add(FetchSignaturesEvent());
        }
      ),
    );
  }

}