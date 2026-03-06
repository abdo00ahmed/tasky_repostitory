import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:second_task/core/app_dialogue/app_dialogue.dart';
import 'package:second_task/core/asset_helper/app_assets.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';
import 'package:second_task/core/network/states_file.dart';
import 'package:second_task/featurs/feature_home_page/screens/data_home/firebase_home/home_firbase.dart';
import 'package:second_task/featurs/feature_home_page/screens/data_home/model_home/task_model.dart';
import 'package:second_task/featurs/feature_home_page/widgets/custom_date_picker.dart';
import 'package:second_task/featurs/feature_home_page/widgets/custom_home_text_form_feild.dart';
import 'package:second_task/featurs/feature_home_page/widgets/priority_alert_dialogue.dart';

class CustomBottomsheet extends StatefulWidget {
  final void Function(DateTime) notifyTasks;
  CustomBottomsheet({super.key, required this.notifyTasks});
  @override
  State<CustomBottomsheet> createState() => _CustomBottomsheetState();
}

class _CustomBottomsheetState extends State<CustomBottomsheet> {
  int? resultt = 1;
  GlobalKey<FormState> textKey1 = GlobalKey();
  TextEditingController? title1 = TextEditingController();
  TextEditingController? desc1 = TextEditingController();

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),

      width: double.infinity,
      height: context.calcHeight(228),
      child: Padding(
        padding: EdgeInsets.only(
          top: context.calcHeight(25),
          right: context.calcWidth(25),
          left: context.calcWidth(25),
        ),
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text(
                "Add Task",
                style: TextStyle(
                  color: Color(0xff24252C).withOpacity(0.87),
                  fontSize: context.calcFonts(20),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.calcHeight(14)),
              child: CustomHomeTextFormFeild(
                textKey: textKey1,
                desc: desc1,
                title: title1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.calcHeight(20)),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    spacing: context.calcWidth(12),
                    children: [
                      InkWell(
                        onTap: () async {
                          selectedDate =
                              await showDatePicker(
                                initialDate: DateTime.now(),
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 30),
                                ),
                              ) ??
                              DateTime.now();
                          print(selectedDate);
                          setState(() {});
                        },
                        child: Image.asset(
                          AppAssets.timer,
                          width: context.calcWidth(24),
                          height: context.calcHeight(24),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          resultt = await showDialog<int>(
                            context: context,
                            builder: (context) {
                              print("$resultt");
                              return PriorityAlertDialogue(result: resultt);
                            },
                          );
                        },
                        child: Image.asset(
                          AppAssets.flag,
                          width: context.calcWidth(24),
                          height: context.calcHeight(24),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      AppDialogue.showLoading(context);
                      print(title1?.text ?? "a");
                      print(desc1?.text ?? "a");
                      final task = TaskModel(
                        date: selectedDate,
                        description: desc1?.text ?? "empty",
                        title: title1?.text ?? "empty",
                        priority: resultt,
                      );
                      print("$resultt");
                      final result1 = await HomeFirbase.addTask(task);
                      switch (result1) {
                        case Succes<TaskModel>():
                          if (desc1 != null) {
                            desc1?.clear();
                          }
                          if (title1 != null) {
                            title1?.clear();
                          }

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                          widget.notifyTasks(selectedDate);
                          ;

                          break;
                        case Error<TaskModel>():
                          Navigator.of(context).pop();
                          AppDialogue.showError(context);
                      }
                    },
                    child: Image.asset(
                      AppAssets.send,
                      width: context.calcWidth(24),
                      height: context.calcHeight(24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() async {
    AppDialogue.showLoading(context);
    print(title1?.text ?? "a");
    print(desc1?.text ?? "a");
    final task = TaskModel(
      date: selectedDate,
      description: desc1?.text ?? "empty",
      title: title1?.text ?? "empty",
      priority: resultt,
    );
    print("$resultt");
    final result1 = await HomeFirbase.addTask(task);
    switch (result1) {
      case Succes<TaskModel>():
        if (desc1 != null) {
          desc1?.clear();
        }
        if (title1 != null) {
          title1?.clear();
        }

        Navigator.of(context).pop();

        break;
      case Error<TaskModel>():
        Navigator.of(context).pop();
        AppDialogue.showError(context);
    }
  }
}
