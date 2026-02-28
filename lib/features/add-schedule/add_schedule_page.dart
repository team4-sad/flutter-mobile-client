import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/add-schedule/bloc/news_signatures_bloc/new_signatures_bloc.dart';
import 'package:miigaik/features/add-schedule/bloc/selected_tag_cubit/selected_tag_cubit.dart';
import 'package:miigaik/features/add-schedule/content/loaded_add_schedule_content.dart';
import 'package:miigaik/features/add-schedule/content/loading_add_schedule_content.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/common/widgets/search_field_widget.dart';
import 'package:miigaik/features/common/widgets/square_filled_icon_button.dart';
import 'package:miigaik/features/common/widgets/tag_widget.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/values.dart';

class AddSchedulePage extends StatelessWidget {
  const AddSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final cubit = SelectedTagCubit();
    final bloc = NewSignaturesBloc();
    final blocSignatures = GetIt.I.get<SignatureScheduleBloc>();

    return Scaffold(
      appBar: SimpleAppBar(title: "Добавить расписание"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: BlocConsumer<SelectedTagCubit, SignatureScheduleType>(
          bloc: cubit,
          listener: (BuildContext context, SignatureScheduleType state) {
            if (bloc.state is NewSignaturesLoaded) {
              bloc.add(
                FetchNewSignaturesEvent(
                  searchText: textController.text,
                  searchType: cubit.state,
                ),
              );
            }
          },
          builder: (context, state) {
            final searchPlaceholder = switch (state) {
              SignatureScheduleType.group => "название группы",
              SignatureScheduleType.audience => "название аудитории",
              SignatureScheduleType.teacher => "преподавателя",
            };
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchFieldWidget(
                          textEditingController: textController,
                          enableClear: true,
                          onConfirm: (_) {
                            bloc.add(
                              FetchNewSignaturesEvent(
                                searchText: textController.text,
                                searchType: cubit.state,
                              ),
                            );
                          },
                          hint: "Введите $searchPlaceholder",
                          onTapClear: () {
                            bloc.add(ClearNewSignaturesEvent());
                          },
                        ),
                      ),
                      10.hs(),
                      SquareFilledIconButton(
                        icon: Icon(I.search, color: context.palette.unAccent),
                        onPress: () {
                          bloc.add(
                            FetchNewSignaturesEvent(
                              searchText: textController.text,
                              searchType: cubit.state,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                10.vs(),
                Row(
                  spacing: 10,
                  children: [
                    TagWidget(
                      title: "Группа",
                      isSelected: state == SignatureScheduleType.group,
                      onTap: () => cubit.setType(SignatureScheduleType.group),
                      isCenter: true,
                    ).f(92),
                    TagWidget(
                      title: "Аудитория",
                      isSelected: state == SignatureScheduleType.audience,
                      onTap: () =>
                        cubit.setType(SignatureScheduleType.audience),
                      isCenter: true,
                    ).f(92),
                    TagWidget(
                      title: "Преподаватель",
                      isSelected: state == SignatureScheduleType.teacher,
                      onTap: () => cubit.setType(SignatureScheduleType.teacher),
                      isCenter: true,
                    ).f(116),
                  ],
                ),
                20.vs(),
                BlocBuilder<NewSignaturesBloc, NewSignaturesState>(
                  bloc: bloc,
                  builder: (context, state) {
                    switch (state) {
                      case NewSignaturesInitial():
                        return SizedBox();
                      case NewSignaturesLoading():
                        return LoadingAddScheduleContent();
                      case NewSignaturesError():
                        return Center(
                          child: PlaceholderWidget.fromException(
                            state.error,
                            () {
                              bloc.add(
                                FetchNewSignaturesEvent(
                                  searchText: textController.text,
                                  searchType: cubit.state,
                                ),
                              );
                            },
                          ),
                        ).p(90.bottom()).e();
                      case NewSignaturesLoaded():
                        return (state.hasNotEmptyData)
                            ? LoadedAddScheduleContent(
                              data: state.data!.where(
                                (e) => (blocSignatures.state is SignatureScheduleLoaded) 
                                  ? !(blocSignatures.state as SignatureScheduleLoaded).data.contains(e)
                                  : true
                              ).toList()
                            )
                            : Center(
                                child: PlaceholderWidget(
                                  title: "Расписание не найдено",
                                  subTitle:
                                      "Измените поисковый запрос\nи попробуйте ещё раз",
                                ),
                              ).p(90.bottom()).e();
                    }
                  },
                ).e(),
              ],
            );
          },
        ),
      ),
    );
  }
}
