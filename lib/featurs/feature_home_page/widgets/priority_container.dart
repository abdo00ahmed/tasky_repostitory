import 'package:flutter/material.dart';
import 'package:second_task/core/asset_helper/app_assets.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';

class PriorityContainer extends StatelessWidget {
  int? priority;
  PriorityContainer({super.key, this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff5F33E1)),
        borderRadius: BorderRadius.circular(5),
      ),
      height: context.calcHeight(29),
      width: context.calcWidth(42),
      child: Row(
        spacing: context.calcWidth(5),
        mainAxisAlignment: .center,
        children: [
          Image.asset(
            AppAssets.flag,
            width: context.calcWidth(14),
            height: context.calcHeight(14),
          ),
          Text("$priority"),
        ],
      ),
    );
  }
}
