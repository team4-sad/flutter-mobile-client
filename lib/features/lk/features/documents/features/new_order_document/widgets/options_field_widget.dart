import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class OptionsFieldWidget extends StatefulWidget {

  final String label;
  final int? defaultIndex;
  final String? hint;
  final List<String> options;

  const OptionsFieldWidget({
    super.key,
    required this.label,
    required this.options,
    this.defaultIndex,
    this.hint,
  });

  @override
  State<OptionsFieldWidget> createState() => _OptionsFieldWidgetState();
}

class _OptionsFieldWidgetState extends State<OptionsFieldWidget> {

  bool isOpened = false;
  int? currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.defaultIndex;
  }

  bool get isHint => currentIndex == null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isOpened = !isOpened;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.label, style: TS.medium15.use(context.palette.text)),
          8.vs(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
            decoration: BoxDecoration(
              color: context.palette.container,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    (isHint) ? widget.hint ?? "" : widget.options[currentIndex!],
                    style: TS.regular15.use((isHint) ? context.palette.subText : context.palette.text)
                  )
                ),
                8.hs(),
                Icon((isOpened)
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
                  size: 20,
                ),
              ],
            ),
          ),
          if (isOpened)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 240
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.palette.container,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14
                  ),
                  child: Scrollbar(
                    radius: Radius.circular(10),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              currentIndex = index;
                              isOpened = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: (index == 0) ? 22 : 12,
                              bottom: (index == widget.options.length-1) ? 22 : 12
                            ),
                            width: double.infinity,
                            child: Text(
                              widget.options[index],
                              style: TS.regular15.use(context.palette.text)
                            )
                          ),
                        ),
                      itemCount: widget.options.length,
                      shrinkWrap: true,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}