import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/schedule_choose_page.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class ScheduleAppBar extends StatelessWidget implements PreferredSizeWidget {
  ScheduleAppBar({super.key}) {
    if (_signatureBloc.state is SignatureScheduleInitial) {
      _signatureBloc.add(FetchSignaturesEvent());
    }
  }

  final SignatureScheduleBloc _signatureBloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ScheduleChoosePage()),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalPaddingPage,
          right: horizontalPaddingPage - 8,
          top: 70,
        ),
        child: Row(
          children: [
            BlocBuilder<SignatureScheduleBloc, SignatureScheduleState>(
              bloc: _signatureBloc,
              builder: (context, state) {
                if (state is SignatureScheduleLoaded && state.hasSelected) {
                  return Text(
                    state.selected!.title,
                    style: TS.medium15.use(context.palette.unAccent),
                  );
                } else {
                  return Text(
                    "Расписание не выбрано",
                    style: TS.medium15.use(context.palette.unAccent),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 59);
}
