import 'package:flutter/material.dart';
import 'package:second_task/core/app_dialogue/app_dialogue.dart';
import 'package:second_task/core/asset_helper/app_assets.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';
import 'package:second_task/core/network/states_file.dart';
import 'package:second_task/featurs/feature_home_page/screens/data_home/firebase_home/home_firbase.dart';
import 'package:second_task/featurs/feature_home_page/screens/data_home/model_home/task_model.dart';

class DetailsPage extends StatefulWidget {
  TaskModel? taskK;

  DetailsPage({this.taskK});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final taskArg = ModalRoute.of(context)?.settings.arguments as TaskModel?;

    final task = taskArg ?? widget.taskK;
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.calcHeight(48)),
              child: Align(
                alignment: AlignmentGeometry.topLeft,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: context.calcHeight(32),
                    width: context.calcWidth(32),
                    decoration: BoxDecoration(
                      color: Color(0xff6E6A7C).withOpacity(0.21),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.close, color: Color(0xffFF4949)),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Checkbox(
                side: BorderSide(color: Color(0xff5F33E1)),
                value: task?.isDone ?? false,
                onChanged: (newvalue) async {
                  setState(() {
                    task?.isDone = newvalue!;
                  });

                  await HomeFirbase.updateTask(task, true);
                },
              ),
              title: Text(
                task?.title ?? "title",
                style: TextStyle(
                  fontSize: context.calcFonts(20),
                  decoration: task?.isDone == true
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              subtitle: Text(
                "${task?.description ?? "Description"}",
                maxLines: 5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    spacing: context.calcWidth(8),
                    children: [
                      Image.asset(AppAssets.timer),
                      Text(
                        "Task Time :",
                        style: TextStyle(
                          color: Color(0xff24252C),
                          fontSize: context.calcFonts(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: context.calcHeight(37),
                    width: context.calcWidth(62),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff6E6A7C).withOpacity(0.21),
                    ),
                    child: Center(
                      child: Text("${task?.date?.day ?? DateTime.now()}"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    spacing: context.calcWidth(8),
                    children: [
                      Image.asset(AppAssets.timer),
                      Text(
                        "Task Priority:",
                        style: TextStyle(
                          color: Color(0xff24252C),
                          fontSize: context.calcFonts(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: context.calcHeight(37),
                    width: context.calcWidth(62),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff6E6A7C).withOpacity(0.21),
                    ),
                    child: Center(child: Text("${task?.priority ?? 1}")),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                spacing: context.calcWidth(8),
                children: [
                  Icon(Icons.delete_outlined, color: Color(0xffFF4949)),
                  TextButton(
                    onPressed: () async {
                      AppDialogue.showLoading(context);
                      final res = await HomeFirbase.deleteTask(task?.id ?? "");
                      switch (res) {
                        case Succes<dynamic>():
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          setState(() {});
                        case Error<dynamic>():
                          AppDialogue.showError(context);
                      }
                    },
                    child: Text(
                      "Delete Task",
                      style: TextStyle(
                        color: Color(0xffFF4949),
                        fontSize: context.calcFonts(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.calcHeight(350)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  height: context.calcHeight(48),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff5F33E1),
                  ),
                  child: Center(
                    child: Text(
                      "Edit Task",
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
      ),
    );
  }
}
