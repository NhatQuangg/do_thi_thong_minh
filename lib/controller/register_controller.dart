import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/repository/authentication/auth_repository.dart';
import 'package:do_thi_thong_minh/repository/authentication/exceptions/signup_email_password_failure.dart';
import 'package:do_thi_thong_minh/repository/users/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final repass = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    AuthRepository.instance.createUserWithEmailAndPassword(email, password);
    print("Dang o registerUser của register_controller");
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  Future<void> createUserDetail(UserModel user) async {
    await userRepo.createUserDetail(user);
    // phoneAuthentication(user.phoneNo!);
  }
//  void phoneAuthentication(String phoneNo){
//   AuthenticationRepository.instance.phoneAuthentication(phoneNo);
// }
}
