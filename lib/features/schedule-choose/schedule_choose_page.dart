import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/content/loading_schedule_choose_content.dart';
import 'package:miigaik/features/schedule-choose/widgets/item_schedule_signature.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class ScheduleChoosePage extends StatelessWidget {
  ScheduleChoosePage({super.key});
  
  final SignatureScheduleBloc bloc = GetIt.I.get(); 
  
  @override
  Widget build(BuildContext context) {
    bloc.add(FetchSignaturesEvent());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){Navigator.pop(context);},
              child: Icon(I.back, color: context.palette.text,),
            ),
            10.hs(),
            Text("Выбор расписания", style: TS.medium20.use(context.palette.text)),
          ],
        ).p(EdgeInsets.only(
          left: horizontalPaddingPage,
          right: horizontalPaddingPage,
          top: 59,
          bottom: 20
        ))
      ),
      floatingActionButton: GestureDetector(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: context.palette.lightText,
            borderRadius: BorderRadius.circular(10.r)
          ),
          child: Center(
            child: Icon(
              I.plus,
              color: context.palette.unAccent,
              size: 36,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: horizontalPaddingPage.horizontal(),
        child: BlocBuilder<SignatureScheduleBloc, SignatureScheduleState>(
          bloc: bloc,
          builder: (context, state) {
            switch(state){
              case SignatureScheduleLoading():
              case SignatureScheduleInitial():
                return LoadingScheduleChooseContent();
              case SignatureScheduleError():
                return Center(
                  child: PlaceholderWidget.fromException(
                    state.error, (){
                      bloc.add(FetchSignaturesEvent());
                    }
                  )
                );
              case SignatureScheduleLoaded():
                return ListView.separated(
                  itemBuilder: (_, index) {
                    final signature = state.data[index];
                    return ItemScheduleSignature(
                      signatureModel: signature,
                      onTap: (_){
                        bloc.add(SelectSignatureEvent(selectedSignature: signature));
                      },
                      isSelected: state.selected == signature
                    );
                  },
                  separatorBuilder: (_, __) => 20.vs(),
                  itemCount: 4
                );
            }
          },
        ),
      ),
    );
  }
}