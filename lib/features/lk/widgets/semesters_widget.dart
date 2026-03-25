import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/lk/widgets/semester_item.dart';
import 'package:miigaik/features/lk/models/semester_entity.dart';
import 'package:miigaik/theme/values.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SemestersWidget extends StatefulWidget {

  final PageController controller;
  final List<SemesterEntity> semesters;
  final void Function(SemesterEntity, int)? onChangeSemester;

  const SemestersWidget({
    super.key,
    required this.semesters,
    this.onChangeSemester,
    required this.controller
  });

  @override
  State<SemestersWidget> createState() => _SemestersWidgetState();
}

class _SemestersWidgetState extends State<SemestersWidget> {

  int currentIndex = 0;

  final itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onChangePage);
  }

  void onChangePage(){
    final newIndex = widget.controller.page?.round();
    if (newIndex != null){
      itemScrollController.scrollTo(
        index: currentIndex,
        duration: Duration(milliseconds: 300),
        alignment: 0.5
      );
      setState(() {
        currentIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      child: ScrollablePositionedList.separated(
        physics: const ClampingScrollPhysics(),
        itemScrollController: itemScrollController,
        padding: EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        scrollDirection: Axis.horizontal,
        itemCount: widget.semesters.length,
        separatorBuilder: (context, index) => 10.hs(),
        itemBuilder: (context, index) => SemesterItem(
          isSelected: index == currentIndex,
          semester: widget.semesters[index],
          onTap: () {
            widget.controller.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.linear
            );
            if (widget.onChangeSemester != null){
              widget.onChangeSemester!(widget.semesters[index], index);
            }
          },
        )
      ),
    );
  }
}