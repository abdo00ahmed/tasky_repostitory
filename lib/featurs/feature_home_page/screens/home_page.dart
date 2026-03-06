import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:second_task/core/app_dialogue/app_dialogue.dart';
import 'package:second_task/core/asset_helper/app_assets.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';
import 'package:second_task/core/network/states_file.dart';
import 'package:second_task/featurs/auth/data/firebase/auth_firebase_database.dart';
import 'package:second_task/featurs/auth/data/model/user_model.dart';
import 'package:second_task/featurs/feature_home_page/screens/data_home/firebase_home/home_firbase.dart';
import 'package:second_task/featurs/feature_home_page/screens/data_home/model_home/task_model.dart';
import 'package:second_task/featurs/feature_home_page/widgets/custom_bottomsheet.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:second_task/featurs/feature_home_page/widgets/priority_container.dart';

class HomePage extends StatefulWidget {
  UserModel? user;
  HomePage({super.key, this.user});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String? querySearch = "";
  DatePickerController _dateController = DatePickerController();
  DateTime? inputDate = DateTime.now();
  bool isLoading = true;
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    getAllTasks(inputDate ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    
    List<TaskModel> activeTasks = tasks.where((t) {
      final hasMatchStatus = (t.isDone ?? false) == false;
      final hasMatchquerySearch = t.title!.toLowerCase().contains(
        querySearch!.toLowerCase(),
      );
      return hasMatchStatus && hasMatchquerySearch;
    }).toList();
    activeTasks.sort((a, b) => (a.priority ?? 1).compareTo(b.priority ?? 1));
    List<TaskModel> completedTasks = tasks.where((t) {
      final hasMatchStatus = (t.isDone ?? false) == true;
      final hasMatchquerySearch = t.title!.toLowerCase().contains(
        querySearch!.toLowerCase(),
      );
      return hasMatchStatus && hasMatchquerySearch;
    }).toList();
    completedTasks.sort((a, b) => (a.priority ?? 1).compareTo(b.priority ?? 1));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 12.5, right: 12.5, top: 10),
          child: SafeArea(
            child: Column(
              spacing: context.calcHeight(16),
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Image.asset(AppAssets.tasky),
                    GestureDetector(
                      onTap: () async {
                        AppDialogue.showLoading(context);
                        var user = UserModel();
                        final result = await AuthFirebaseDatabase.deleteUser(
                          user,
                        );
                        switch (result) {
                          case Succes<String>():
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("l");
                            break;
                          case Error<String>():
                            Navigator.of(context).pop();
                            AppDialogue.showError(context);
                        }
                      },
                      child: Row(
                        spacing: context.calcWidth(10),
                        children: [
                          Image.asset(AppAssets.logout),
                          Text(
                            "Log out",
                            style: TextStyle(
                              color: Color(0xffFF4949),
                              fontSize: context.calcFonts(16),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                DatePicker(
                  controller: _dateController,
                  height: context.calcHeight(80),
                  DateTime.now(),
                  initialSelectedDate: inputDate,
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (selectedDate) {
                    setState(() {
                      inputDate = selectedDate;
                      getAllTasks(inputDate ?? DateTime.now());
                    });
                  },
                ),
                TextField(
                  onChanged: (value) => setState(() {
                    querySearch = value;
                  }),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xff5F33E1),
                      size: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xff6E6A7C)),
                    ),

                    hint: Text(
                      "Search for your task...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7F7F7F),
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : activeTasks.isEmpty && completedTasks.isEmpty
                    ? EmptyHomeScreen()
                    : Expanded(
                        child: ListView(
                          children: [
                            ...activeTasks
                                .map((task) => buildTaskItem(task))
                                .toList(),

                            SizedBox(height: 20),

                            if (completedTasks.isNotEmpty) ...[
                              Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: context.calcFonts(18),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              ...completedTasks
                                  .map((task) => buildTaskItem(task))
                                  .toList(),
                            ],
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              constraints: BoxConstraints(maxHeight: double.infinity),
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsetsGeometry.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CustomBottomsheet(
                    notifyTasks: (newDate) {
                      setState(() {
                        inputDate = newDate;
                        _dateController.animateToDate(newDate);
                        getAllTasks(newDate);
                      });
                    },
                  ),
                );
              },
            );
          },
          backgroundColor: Color(0xff24252C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
          child: Icon(Icons.add, color: Color(0xff5F33E1)),
        ),
      ),
    );
  }

  void getAllTasks(DateTime inputDate) async {
    isLoading = true;
    final allTasks = await HomeFirbase.getTasks(inputDate);
    switch (allTasks) {
      case Succes<List<TaskModel>>():
        isLoading = false;
        tasks = allTasks.data ?? [];
        tasks.sort((a, b) => (a.priority ?? 1).compareTo(b.priority ?? 1));

        setState(() {});
      case Error<List<TaskModel>>():
        isLoading = false;
        AppDialogue.showError(context);
    }
  }

  Widget buildTaskItem(TaskModel task) {
    return Padding(
      padding: EdgeInsets.only(top: context.calcHeight(16)),
      child: ListTile(
        onLongPress: () {
          Navigator.of(context).pushNamed('d', arguments: task);
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xff6E6A7C)),
          borderRadius: BorderRadius.circular(10),
        ),
        trailing: PriorityContainer(priority: task.priority ?? 1),
        leading: Checkbox(
          side: BorderSide(color: Color(0xff5F33E1)),
          value: task.isDone ?? false,
          onChanged: (newvalue) async {
            setState(() {
              task.isDone = newvalue!;
            });

            await HomeFirbase.updateTask(task, true);
          },
        ),
        title: Text(
          task.title ?? "",
          style: TextStyle(
            fontSize: context.calcFonts(15),
            decoration: task.isDone == true ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text("${task.date ?? 1}"),
      ),
    );
  }
}

class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // توسيط العناصر
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: context.calcHeight(50)),
            child: Image.asset(
              AppAssets.pushNotifications,
              height: context.calcHeight(200), // حدد طول مناسب للصورة
            ),
          ),
          SizedBox(height: context.calcHeight(20)),
          Text(
            "What do you want to do today?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff24252C).withOpacity(0.87),
              fontSize: context.calcFonts(20),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Tap + to add your tasks",
            style: TextStyle(
              color: Color(0xff24252C).withOpacity(0.87),
              fontSize: context.calcFonts(16),
            ),
          ),
        ],
      ),
    );
  }
}
