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
  RootPage({super.key});

  final Map<ItemNavBar, int> _itemNavBarToIndex = {};
  final List<Widget> _loadedScreens = [];

  void _updateLazyBuild(ItemNavBar itemNavBar) {
    if (!_itemNavBarToIndex.containsKey(itemNavBar)) {
      final Widget widget = switch(itemNavBar){
        ItemNavBar.schedule => const EmptyPage(),
        ItemNavBar.map => const EmptyPage(),
        ItemNavBar.news => const NewsPage(),
        ItemNavBar.notes => const EmptyPage(),
        ItemNavBar.profile => const EmptyPage()
      };
      var index = _loadedScreens.length;
      _loadedScreens.add(widget);
      _itemNavBarToIndex[itemNavBar] = index;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    _updateLazyBuild(ItemNavBar.defaultItem());
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<BottomNavBarBloc, BottomNavBarState>(
            bloc: GetIt.I.get<BottomNavBarBloc>(),
            listener: (context, state){
              _updateLazyBuild(state.currentItem);
            },
            builder: (context, state){
              return IndexedStack(
                index: _itemNavBarToIndex[state.currentItem],
                children: _loadedScreens,
              );
            },
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