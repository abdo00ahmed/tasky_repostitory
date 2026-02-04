import 'package:second_task/featurs/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthFirebaseDatabase {
  static CollectionReference<UserModel> _getCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collection)
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  static Future<void> addUser(UserModel user) async {
    await _getCollection().doc(user.id).set(user);
  }
}
