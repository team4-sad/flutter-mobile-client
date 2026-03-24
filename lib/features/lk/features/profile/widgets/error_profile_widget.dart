import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/features/lk/features/profile/bloc/profile_bloc/profile_bloc.dart';

class ErrorProfileWidget extends StatelessWidget {
  ErrorProfileWidget({
    super.key,
    required this.error,
  });

  final Object error;
  final ProfileBloc profileBloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: PlaceholderWidget.fromException(error,
        (){
          profileBloc.add(GetProfileEvent());
        }
      ),
    );
  }
}