import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/bottom_nav_bar_gradient.dart';
import 'package:miigaik/features/root/features/bottom-nav-bar/items_nav_bar.dart';
import 'package:miigaik/features/root/tabs/empty/emty_page.dart';
import 'package:miigaik/features/root/tabs/news/news_page.dart';
import 'package:miigaik/features/root/tabs/profile/profile_page.dart';
import 'package:miigaik/features/root/tabs/schedule/schedule_page.dart';
import 'package:talker_flutter/talker_flutter.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});

  final Map<ItemNavBar, int> _itemNavBarToIndex = {};
  final List<Widget> _loadedScreens = [];

  void _updateLazyBuild(ItemNavBar itemNavBar) {
    if (!_itemNavBarToIndex.containsKey(itemNavBar)) {
      final Widget widget = switch (itemNavBar) {
        ItemNavBar.schedule => const SchedulePage(),
        ItemNavBar.map => const EmptyPage(),
        ItemNavBar.news => const NewsPage(),
        ItemNavBar.notes => const EmptyPage(),
        ItemNavBar.profile => const ProfilePage(),
      };
      var index = _loadedScreens.length;
      _loadedScreens.add(widget);
      _itemNavBarToIndex[itemNavBar] = index;
    }
  }

  SystemUiOverlayStyle _getUiOverlayStyle(ItemNavBar itemNavBar) {
    switch (itemNavBar) {
      case ItemNavBar.schedule:
        return SystemUiOverlayStyle.light;
      case ItemNavBar.map:
      case ItemNavBar.news:
      case ItemNavBar.notes:
      case ItemNavBar.profile:
        return SystemUiOverlayStyle.dark;
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
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: _getUiOverlayStyle(state.currentItem),
                child: IndexedStack(
                  index: _itemNavBarToIndex[state.currentItem],
                  children: _loadedScreens,
                ),
              );
            },
          ),
          GestureDetector(
            onLongPress: (){
              if (kDebugMode) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TalkerScreen(talker: GetIt.I.get())
                  )
                );
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavBarGradient(
                bottomNavBar: BottomNavBar()
              )
            ),
          )
        ],
      ),
    );
  }
}