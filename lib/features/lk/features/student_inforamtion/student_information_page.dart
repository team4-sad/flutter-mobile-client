import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/profile/bloc/profile_bloc/profile_bloc.dart';
import 'package:miigaik/features/lk/features/student_inforamtion/widgets/loaded_information.dart';
import 'package:miigaik/features/lk/features/student_inforamtion/widgets/loading_information.dart';
import 'package:miigaik/theme/values.dart';

class StudentInformationPage extends StatelessWidget {
  const StudentInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Информация о студенте",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: GetIt.I.get(),
          builder: (context, state){
            return switch(state){
              ProfileInitial() => LoadingInformation(),
              ProfileLoading() => LoadingInformation(),
              ProfileError(error: var err) => Center(
                child: PlaceholderWidget.fromException(err)
              ),
              ProfileLoaded(profile: var profile) => LoadedInformation(
                educationInfo: profile.educationInfo.last,
                family: profile.family,
              )
            };
          },
        )
      ),
    );
  }
}