import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNo;
  final String? password;
  final String? level;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.level,
  });

  // chuyển đối tượng UserModel -> Json.
  // Dùng để lưu trữ data vào Cloud FireStore
  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "Level": level
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullName: data["FullName"],
        email: data["Email"],
        phoneNo: data["Phone"],
        password: data["Password"],
        level: data["Level"]);
  }
}
