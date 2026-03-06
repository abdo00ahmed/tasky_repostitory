import 'package:flutter/material.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime day) onDaySelected;

  CustomDatePicker({super.key, required this.onDaySelected});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime focusedDayy = DateTime.now();
  DateTime? selectedDayy;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: context.calcWidth(327),
        height: context.calcHeight(250),
        child: TableCalendar(
          focusedDay: focusedDayy,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 12, 31),

          selectedDayPredicate: (day) => isSameDay(selectedDayy, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              selectedDayy = selectedDay;
              focusedDayy = focusedDay;
            });
            widget.onDaySelected(selectedDay);
          },
        ),
      ),
      actions: [
        Row(
          spacing: context.calcWidth(5),
          children: [
            Expanded(
              child: InkWell(
                child: Container(
                  height: context.calcHeight(48),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color(0xff5F33E1),
                        fontSize: context.calcFonts(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: context.calcHeight(48),
                  decoration: BoxDecoration(
                    color: Color(0xff5F33E1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: context.calcFonts(16),
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
