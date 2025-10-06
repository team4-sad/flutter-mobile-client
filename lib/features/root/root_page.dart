import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:miigaik/features/root/tabs/news/news.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: GetIt.I.get<BottomNavBarBloc>(),
        builder: (context, state) {
          return NewsPage();
        }
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}