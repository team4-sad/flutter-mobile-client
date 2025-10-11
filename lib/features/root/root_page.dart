import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bottom_nav_bar_gradient.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/items_nav_bar.dart';
import 'package:miigaik/features/root/tabs/empty/emty_page.dart';
import 'package:miigaik/features/root/tabs/news/news_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {

    final pages = ItemNavBar.values.map((e) => switch(e){
      ItemNavBar.schedule => EmptyPage(),
      ItemNavBar.map => EmptyPage(),
      ItemNavBar.news => NewsPage(),
      ItemNavBar.notes => EmptyPage(),
      ItemNavBar.profile => EmptyPage(),
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder(
            bloc: GetIt.I.get<BottomNavBarBloc>(),
            builder: (context, BottomNavBarState state) {
              return IndexedStack(
                index: state.currentItem.index,
                children: pages,
              );
            }
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavBarGradient(
              bottomNavBar: BottomNavBar()
            )
          )
        ],
      ),
    );
  }
}