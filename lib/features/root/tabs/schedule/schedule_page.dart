import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/schedule_choose_page.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';
import 'package:sheet/sheet.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final SignatureScheduleBloc _signatureBloc = GetIt.I.get();

  @override
  void initState() {
    super.initState();
    _signatureBloc.add(FetchSignaturesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.palette.lightText,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.only(left: horizontalPaddingPage,
                right: horizontalPaddingPage - 8,
                top: 59),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<SignatureScheduleBloc, SignatureScheduleState>(
                  bloc: _signatureBloc,
                  builder: (context, state) {
                    if (state is SignatureScheduleLoaded && state.hasSelected) {
                      return Text(
                        state.selected!.title,
                        style: TS.medium15.use(context.palette.unAccent),
                      );
                    }else{
                      return Text(
                        "Расписание не выбрано",
                        style: TS.medium15.use(context.palette.unAccent),
                      );
                    }
                  },
                ).e(),
                20.hs(),
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ScheduleChoosePage())
                  );
                }, icon: Icon(
                  I.choose,
                  color: context.palette.unAccent,
                  size: 28,
                ),),
              ],
            ),
          )
        ),
        body: Sheet(
          minExtent: 222,
          maxExtent: 560.h,
          child: Container(color: context.palette.background),
        )
    );
  }
}