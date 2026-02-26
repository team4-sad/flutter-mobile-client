import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/schedule-choose/bloc/selecting_schedule_choose_page_cubit/selecting_schedule_choose_page_cubit.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPress;

  SelectionAppBar({
    super.key, 
    required this.onBackPress,
    required
  });

  final SelectingScheduleChoosePageCubit cubit = GetIt.I.get();
  final SignatureScheduleBloc bloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPaddingPage,
        right: horizontalPaddingPage,
        top: 59,
        bottom: 12,
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onBackPress,
            child: Padding(
              padding: EdgeInsetsGeometry.all(8),
              child: Icon(I.back, color: context.palette.text)
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onAllSelectionPress,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Выделить все", style: TS.regular14.use(context.palette.text)),
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      value: isAllSelection,
                      onChanged: (_) => onAllSelectionPress()
                    )
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onAllSelectionPress(){
    if (isAllSelection){
      cubit.clear();
    }else{
      final List<SignatureScheduleModel> toAllSelection;
      if (bloc.state is SignatureScheduleLoaded){
        toAllSelection = (bloc.state as SignatureScheduleLoaded).data;
      }else{
        toAllSelection = [];
      }
      cubit.allSelect(toAllSelection);
    }
  }

  bool get isAllSelection =>
      cubit.state != null && bloc.state is SignatureScheduleLoaded &&
      cubit.state!.length == (bloc.state as SignatureScheduleLoaded).data.length;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 59);
}
