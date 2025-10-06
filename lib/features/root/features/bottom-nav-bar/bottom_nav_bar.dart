import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/values.dart';

import 'bloc/bottom_nav_bar_bloc.dart';
import 'items_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: horizontalMarginNavBar.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: heightNavBar.w,
            decoration: BoxDecoration(
              color: context.palette.background,
              border: Border.all(
                  color: context.palette.container
              ),
              borderRadius: BorderRadius.circular(borderRadiusNavBar.r)
            ),
            padding: EdgeInsets.symmetric(horizontal: horizontalPaddingNavBar.w),
            child: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
              bloc: GetIt.I.get(),
              builder: (BuildContext context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ItemNavBar.values.map(
                    (e) => _ItemBottomNavBar(
                      item: e,
                      isSelected: state.currentItem == e,
                    )
                  ).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemBottomNavBar extends StatelessWidget {
  final ItemNavBar item;
  final bool isSelected;

  const _ItemBottomNavBar({required this.item, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        GetIt.I.get<BottomNavBarBloc>().add(GoToEventEvent(item));
      },
      child: SizedBox(
        width: widthTapItemNavBar.w,
        child: Center(
          child: Icon(
            item.icon,
            color: (isSelected) ? context.palette.accent : context.palette.subText,
            size: sizeIconNavBar.w,
          ),
        ),
      ),
    );
  }
}