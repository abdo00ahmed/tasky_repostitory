import 'package:flutter/material.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';
import 'package:second_task/featurs/feature_home_page/widgets/custom_item_priority.dart';

class PriorityAlertDialogue extends StatefulWidget {
  int? result = 1;
  PriorityAlertDialogue({super.key, required this.result});

  @override
  State<PriorityAlertDialogue> createState() => _PriorityAlertDialogueState();
}

class _PriorityAlertDialogueState extends State<PriorityAlertDialogue> {
  int selectedIndex = 1;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.result ?? 1;
  }

  List<CustomItemPriority> priorities = [
    CustomItemPriority(index: 1, isSelected: false),
    CustomItemPriority(index: 2, isSelected: false),
    CustomItemPriority(index: 3, isSelected: false),
    CustomItemPriority(index: 4, isSelected: false),
    CustomItemPriority(index: 5, isSelected: false),
    CustomItemPriority(index: 6, isSelected: false),
    CustomItemPriority(index: 7, isSelected: false),
    CustomItemPriority(index: 8, isSelected: false),
    CustomItemPriority(index: 9, isSelected: false),
    CustomItemPriority(index: 10, isSelected: false),
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Task Priority",
        style: TextStyle(
          color: Color(0xff24252C).withOpacity(0.87),
          fontSize: context.calcFonts(16),
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SizedBox(
        height: context.calcHeight(360),
        width: context.calcWidth(327),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: context.calcWidth(16),
            mainAxisSpacing: context.calcHeight(12),
          ),
          itemCount: priorities.length,
          itemBuilder: (context, index) {
            int currentPriority = index + 1;
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = currentPriority;
                });
              },
              child: CustomItemPriority(
                index: currentPriority,
                isSelected: selectedIndex == currentPriority,
              ),
            );
          },
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: context.calcHeight(48),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cnacel",
                      style: TextStyle(
                        fontSize: context.calcFonts(16),
                        color: Color(0xff5F33E1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff5F33E1),
                  borderRadius: BorderRadius.circular(4),
                ),
                height: context.calcHeight(48),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      print(widget.result);
                      setState(() {
                        widget.result = selectedIndex;
                        Navigator.of(context).pop(widget.result);
                      });
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: context.calcFonts(16),
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
