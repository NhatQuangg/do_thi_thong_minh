import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/repository/authentication/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  late final Rx<User?> firebaseUser;

  final _authRepo = Get.put(AuthRepository());

  createUser(UserModel user) async {
    final email = _authRepo.firebaseUser.value!.email;
    print("day la email: $email");
    if (email != null) {
      await _db.collection("Users").add(user.toJson())
          .catchError((error) {
        print("Error: " + error.toString());
      });
    } else {
      print("Can't create user in firestore");
    }
  }

  createUserDetail(UserModel user) async {
    await _db.collection("Users").doc(user.email).set({
      "fullName": user.fullName,
      "email": user.email,
      "phone": user.phoneNo,
      "password": user.password,
      "level": user.level
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
    await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData =
    snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }
}
