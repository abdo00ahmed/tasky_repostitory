import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_task/core/network/states_file.dart';
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

  static Future<Result<String>> loginUser(UserModel user) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email ?? "",
        password: user.password ?? "",
      );

      return Succes();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Error("your password is too weak");
      } else if (e.code == 'email-already-in-use') {
        print("email-already-in-use");
        return Error("email-already-in-use");
      }
    } catch (e) {
      print(e);
      return Error("$e");
    }
    return Error("something wrong");
  }

  static Future<Result<String>> createUser(UserModel user) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email ?? "",
            password: user.password ?? "",
          );

      return Succes(data: credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Error("weak-password");
      } else if (e.code == 'email-already-in-use') {
        return Error("email-already-in-use");
      }
    } catch (e) {
      print(e);
      return Error("email-already-in-use");
    }
    return Error("");
  }

  static Future<Result<String>> deleteUser(UserModel user) async {
    try {
      FirebaseAuth.instance.signOut();
      return Succes();
    } catch (e) {
      return Error(e.toString());
    }
  }
}
