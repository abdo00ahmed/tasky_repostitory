import 'package:flutter/material.dart';
import 'package:second_task/core/asset_helper/app_assets.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';

class CustomItemPriority extends StatefulWidget {
  int index;
  bool isSelected;
  CustomItemPriority({
    super.key,
    required this.index,
    required this.isSelected,
  });

  @override
  State<CustomItemPriority> createState() => _CustomItemPriorityState();
}

class _CustomItemPriorityState extends State<CustomItemPriority> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isSelected ? Color(0xff5F33E1) : Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(4),
        border: widget.isSelected
            ? Border.all(color: Color(0xff5F33E1))
            : Border.all(color: Color(0xff6E6A7C)),
      ),
      height: context.calcHeight(64),
      width: context.calcWidth(64),
      child: Column(
        mainAxisAlignment: .center,
        spacing: context.calcHeight(7),
        children: [
          Image.asset(
            widget.isSelected ? AppAssets.whiteFlag : AppAssets.flag,
            height: context.calcHeight(24),
            width: context.calcWidth(24),
          ),
          Text("${widget.index}"),
        ],
      ),
    );
  }
}
