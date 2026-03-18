import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/extensions/date_time_extensions.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/schedule/bloc/current_time_cubit/current_time_cubit.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemBetweenLessons extends StatelessWidget {
  final DateTime beforeDateTime;
  final DateTime afterDateTime;
  final Duration duration;

  const ItemBetweenLessons({super.key, required this.duration, required this.beforeDateTime, required this.afterDateTime});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentTimeCubit, CurrentTimeState>(
      bloc: GetIt.I.get(),
      builder: (BuildContext context, CurrentTimeState state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: BoxBorder.all(
              color: state.currentDateTime.isBetween(beforeDateTime, afterDateTime)
                  ? context.palette.tag
                  : context.palette.container,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Перерыв",
                  style: TS.regular12.use(context.palette.tag),
                ),
              ),
              Icon(I.schedule, color: context.palette.tag),
              3.hs(),
              Text(
                "${duration.inMinutes} мин.",
                style: TS.regular12.use(context.palette.tag),
              ),
            ],
          ),
        );
      },
    );
  }
}
