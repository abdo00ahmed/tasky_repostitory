import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_task/core/network/states_file.dart';
import 'package:second_task/featurs/auth/data/model/user_model.dart';
import 'package:second_task/featurs/feature_home_page/screens/data_home/model_home/task_model.dart';

abstract class HomeFirbase {
  static CollectionReference<TaskModel> getCollection() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection(UserModel.collection)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .doc(uid)
        .collection(TaskModel.collection)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.tojson(),
        );
  }

  static Future<Result<TaskModel>> addTask(TaskModel task) async {
    try {
      final doc = getCollection().doc();
      task.id = doc
          .id; // now id attrbiute has the auto id , after this every task will has a uinque id
      await doc.set(task);
      return Succes<TaskModel>(data: task);
    } catch (e) {
      return Error<TaskModel>(e.toString());
    }
  }

  static Future<Result<TaskModel>> updateTask(
    TaskModel? task,
    bool newStatus,
  ) async {
    try {
      final resuit = await getCollection().doc(task?.id).update({
        'isDone': newStatus,
      });
      return Succes();
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<Result<List<TaskModel>>> getTasks(DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    try {
      final querySnapshot = await getCollection()
          .where("date", isEqualTo: normalizedDate.millisecondsSinceEpoch)
          .get();
      final docs = querySnapshot.docs;
      final listOfTasks = docs.map<TaskModel>((doc) => doc.data()).toList();
      return Succes<List<TaskModel>>(data: listOfTasks);
    } catch (e) {
      return Error<List<TaskModel>>(e.toString());
    }
  }

  static Future<Result> deleteTask(String id) async {
    try {
      await getCollection().doc(id).delete();
      return Succes();
    } catch (e) {
      print("error deleting task: $e");
      return Error(e.toString());
    }
  }
}
