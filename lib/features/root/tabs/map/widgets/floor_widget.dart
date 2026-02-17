import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/map/bloc/floor_map_cubit/floor_map_cubit.dart';
import 'package:miigaik/features/root/tabs/map/bloc/map_cubit/map_cubit.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class FloorWidget extends StatefulWidget {

  final int floorCount;

  const FloorWidget({super.key, required this.floorCount});

  @override
  State<FloorWidget> createState() => _FloorWidgetState();
}

class _FloorWidgetState extends State<FloorWidget> {

  bool showUpButton = false;
  bool showDownButton = false;

  final scrollController = ScrollController();

  final double pxToFloor = 40;
  late final double maxScroll;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      maxScroll = scrollController.position.maxScrollExtent;
      scrollController.addListener(refreshButtons);
      refreshButtons();
    });
  }

  void refreshButtons() {
    final position = scrollController.position.pixels;
    final currentFloor = position / pxToFloor;
    setState(() {
      showUpButton = currentFloor < widget.floorCount - 4;
      showDownButton = currentFloor > 0;
    });
  }

  final cubit = GetIt.I.get<FloorMapCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FloorMapCubit, int>(
      bloc: cubit,
      listener: (context, state){
        final value = (state - 2) * pxToFloor;
        if (value > maxScroll) {
          scrollController.jumpTo(maxScroll);
        } else if (value < 0) {
          scrollController.jumpTo(0);
        } else {
          scrollController.jumpTo(value);
        }
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 160,
            width: 48,
            color: context.palette.container,
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  reverse: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) =>
                    _FloorItem(
                      key: ValueKey(index),
                      floor: index + 1,
                      heightFloor: pxToFloor,
                      isFirst: index == 0,
                      isSelected: index == state - 1,
                      isLast: index == widget.floorCount - 1
                    ),
                  itemCount: widget.floorCount
                ),
                if (showUpButton)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: _FloorButton(
                        key: ValueKey("up"),
                        contentPadding: EdgeInsets.only(top: 7),
                        onTap: () {
                          scrollController.jumpTo(
                              scrollController.offset + pxToFloor);
                        },
                        icon: Icons.arrow_drop_up
                      ),
                    )
                  ),
                if (showDownButton)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(),
                      child: _FloorButton(
                        key: ValueKey("down"),
                        contentPadding: EdgeInsets.only(bottom: 7),
                        onTap: () {
                          scrollController.jumpTo(
                              scrollController.offset - pxToFloor);
                        },
                        icon: Icons.arrow_drop_down
                      ),
                    )
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FloorItem extends StatelessWidget {

  final int floor;
  final double heightFloor;
  final bool isSelected;
  final bool isLast;
  final bool isFirst;

  const _FloorItem({
    super.key,
    required this.floor,
    required this.heightFloor,
    this.isSelected = false,
    this.isLast = false,
    this.isFirst = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GetIt.I.get<FloorMapCubit>().change(floor);
      },
      child: Container(
        height: heightFloor,
        width: 48,
        color: (isSelected) ? context.palette.subText : Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: isFirst ? 7 : 0,
            top: isLast ? 7 : 0
          ),
          child: Center(
            child: Text(
              floor.toString(),
              style: TS.regular15.use((isSelected) ? context.palette.container : context.palette.subText),
            )
          ),
        ),
      ),
    );
  }
}

class _FloorButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final EdgeInsets contentPadding;

  const _FloorButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.contentPadding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 48,
      color: context.palette.container,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: contentPadding,
            child: Center(
              child: Icon(icon, color: context.palette.subText,)
            ),
          ),
        ),
      ),
    );
  }
}