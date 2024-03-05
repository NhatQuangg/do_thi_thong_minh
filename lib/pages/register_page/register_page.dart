import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/constants/my_button.dart';
import 'package:do_thi_thong_minh/constants/my_textfield.dart';
import 'package:do_thi_thong_minh/constants/square_tile.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/controller/register_controller.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/pages/login_page/login_page.dart';
import 'package:do_thi_thong_minh/repository/authentication/auth_repository.dart';
import 'package:do_thi_thong_minh/repository/authentication/exceptions/signup_email_password_failure.dart';
import 'package:do_thi_thong_minh/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  // final Function()? onTap;
  // const RegisterPage({Key? key, required this.onTap});

  const RegisterPage({Key? key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(RegisterController());
  String levelUser = '1';

  final _formKey = GlobalKey<FormState>();

  void signUserUp() async {
    try {
      if (controller.email.text.trim() == null ||
          controller.email.text.trim() == "") {
        AnimatedSnackBar.material(
          'Vui lòng nhập email!',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
        print("Chưa nhập email");
      } else if (controller.password.text.trim() == null ||
          controller.password.text.trim() == "") {
        AnimatedSnackBar.material(
          'Vui lòng nhập mật khẩu!',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
        print("Chưa nhập mk");
      } else if (controller.repass.text != controller.password.text.trim() ||
          controller.repass.text == "") {
        AnimatedSnackBar.material(
          'Nhập lại mật khẩu không chính xác!',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
        print("Chưa nhập lai mk");
      } else {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: controller.email.text.trim(),
                password: controller.password.text.trim());

        final user = UserModel(
          fullName: controller.fullName.text.trim(),
          email: controller.email.text.trim(),
          phoneNo: controller.phoneNo.text.trim(),
          password: controller.password.text.trim(),
          level: levelUser,
        );

        FirebaseFirestore.instance
            .collection("Users")
            .add(user.toJson())
            .then((value) {
            AnimatedSnackBar.material(
              'Đăng ký thành công',
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            ).show(context);
            controller.fullName.text = "";
            controller.email.text = "";
            controller.phoneNo.text = "";
            controller.password.text = "";
            controller.repass.text = "";
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
        });

        print("Đăng ký thành công....");
      }
    } on FirebaseAuthException catch (e) {
      print("day la loi:  ${e.message}");
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      AnimatedSnackBar.material(
        "${ex.message}",
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
      throw ex;
    }
  }

  // void signUserupp() async {
  //   if (controller.email.text.trim() == null || controller.email.text.trim() == "") {
  //     // Navigator.pop(context);
  //     AnimatedSnackBar.material(
  //       'Vui lòng nhập email!',
  //       type: AnimatedSnackBarType.error,
  //       mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  //     ).show(context);
  //     print("Chưa nhập email");
  //   } else if (controller.password.text.trim() == null || controller.password.text.trim() == "") {
  //     // Navigator.pop(context);
  //     AnimatedSnackBar.material(
  //       'Vui lòng nhập mật khẩu!',
  //       type: AnimatedSnackBarType.error,
  //       mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  //     ).show(context);
  //     print("Chưa nhập mk");
  //   } else if (controller.repass.text != controller.password.text.trim() || controller.repass.text == "") {
  //     // Navigator.pop(context);
  //     AnimatedSnackBar.material(
  //       'Nhập lại mật khẩu không chính xác!',
  //       type: AnimatedSnackBarType.error,
  //       mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  //     ).show(context);
  //   }
  //   else {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //     });
  //
  //     bool registerUser = await RegisterController.instance.registerUser(
  //         controller.email.text.trim(),
  //         controller.password.text.trim()
  //     );
  //     if (registerUser) {
  //       final user = UserModel(
  //         fullName: controller.fullName.text.trim(),
  //         email: controller.email.text.trim(),
  //         phoneNo: controller.phoneNo.text.trim(),
  //         password: controller.password.text.trim(),
  //         level: levelUser,
  //       );
  //       await RegisterController.instance.createUser(user).then((value) {
  //         AnimatedSnackBar.material(
  //           'Đăng ký thành công',
  //           type: AnimatedSnackBarType.success,
  //           mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  //         ).show(context);
  //         controller.fullName.text = "";
  //         controller.email.text = "";
  //         controller.phoneNo.text = "";
  //         controller.password.text = "";
  //         controller.repass.text = "";
  //         Navigator.pop(context);
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => LoginPage()),
  //         );
  //       });
  //       print("Đăng ký thành công....");
  //     } else {
  //       // Đăng ký thất bại, in ra thông báo tương ứng
  //       Navigator.pop(context);
  //       AnimatedSnackBar.material(
  //         'Đăng ký thất bại',
  //         type: AnimatedSnackBarType.error,
  //         mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  //       ).show(context);
  //       print("Đăng ký thất bại. Vui lòng thử lại sau.");
  //     }
  //   }
  // }
  // // text editing controllers
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  // final confirmPasswordController = TextEditingController();
  //
  // // sign user in method
  // void signUserUppp() async {
  //   // try register
  //   try {
  //     print(passwordController.text);
  //     print(confirmPasswordController.text);
  //     if (emailController.text == null || emailController.text == "") {
  //       AnimatedSnackBar.material("Vui lòng nhập email!",
  //               type: AnimatedSnackBarType.error,
  //               mobileSnackBarPosition: MobileSnackBarPosition.bottom)
  //           .show(context);
  //       print('Chua nhap email');
  //     } else if (passwordController.text == null ||
  //         passwordController.text == "") {
  //       AnimatedSnackBar.material("Vui lòng nhập mật khẩu!",
  //               type: AnimatedSnackBarType.error,
  //               mobileSnackBarPosition: MobileSnackBarPosition.bottom)
  //           .show(context);
  //       print('Chua nhap mk');
  //     } else if (confirmPasswordController.text == null ||
  //         confirmPasswordController.text == "") {
  //       AnimatedSnackBar.material("Vui lòng nhập lại mật khẩu!",
  //               type: AnimatedSnackBarType.error,
  //               mobileSnackBarPosition: MobileSnackBarPosition.bottom)
  //           .show(context);
  //     } else if (passwordController.text == confirmPasswordController.text) {
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return const Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           });
  //
  //       // create the user
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(
  //               email: emailController.text, password: passwordController.text);
  //       // after creating the user, create a new document in cloud firestore called Users
  //       final user = UserModel(
  //         fullName: controller.fullName.text.trim(),
  //         email: controller.email.text.trim(),
  //         phoneNo: controller.phoneNo.text.trim(),
  //         password: controller.password.text.trim(),
  //         level: levelUser,
  //       );
  //       FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(userCredential.user!.email).set(
  //           {
  //         'fullname' : emailController.text.split('@')[0],   // initial username
  //         'level' : 1,  // 0: admin, 1: user
  //         'password': passwordController.text,
  //         'phone': 'Rỗng'
  //       }
  //       );
  //       print('dki thanh cong');
  //       Navigator.pop(context);
  //
  //       AnimatedSnackBar.material(
  //         "Đăng ký thành công!",
  //         type: AnimatedSnackBarType.success,
  //         mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  //       ).show(context);
  //
  //       Future.delayed(const Duration(seconds: 0), () {
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => LoginPage()),
  //         );
  //       });
  //     } else {
  //       AnimatedSnackBar.material("Nhập lại mật khẩu không đúng!",
  //               type: AnimatedSnackBarType.error,
  //               mobileSnackBarPosition: MobileSnackBarPosition.bottom)
  //           .show(context);
  //       print('mk sai');
  //     }
  //     // Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     Navigator.pop(context);
  //     print(e.message);
  //     if (e.message ==
  //         'An unknown error occurred: FirebaseError: Firebase: The email address is badly formatted. (auth/invalid-email).') {
  //       AnimatedSnackBar.material(
  //               "Định dạng email không đúng. Vui lòng thử lại!",
  //               type: AnimatedSnackBarType.error,
  //               mobileSnackBarPosition: MobileSnackBarPosition.bottom)
  //           .show(context);
  //       print('format email sai');
  //     } else if (e.message ==
  //         'An unknown error occurred: FirebaseError: Firebase: The email address is already in use by another account. (auth/email-already-in-use).') {
  //       AnimatedSnackBar.material("Email đã tồn tại. Vui lòng thử lại!",
  //               type: AnimatedSnackBarType.error,
  //               mobileSnackBarPosition: MobileSnackBarPosition.bottom)
  //           .show(context);
  //       print('email ton tai');
  //     } else if (e.message ==
  //         'An unknown error occurred: FirebaseError: Firebase: Password should be at least 6 characters (auth/weak-password).') {
  //       print('mk iu');
  //       AnimatedSnackBar.material("Mật khẩu yếu. Vui lòng thử lại!",
  //               type: AnimatedSnackBarType.error,
  //               mobileSnackBarPosition: MobileSnackBarPosition.bottom)
  //           .show(context);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  Text(
                    'ĐĂNG KÝ',
                    style: GoogleFonts.roboto(
                        color: Color(0xFF109ea2),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 25),

                  // fullname textfield
                  MyTextField(
                    controller: controller.fullName,
                    hintText: 'Họ và tên',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),

                  // username textfield
                  MyTextField(
                    controller: controller.email,
                    hintText: 'Tên đăng nhập',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),

                  // phone textfield
                  MyTextField(
                    controller: controller.phoneNo,
                    hintText: 'Số điện thoại',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password
                  MyTextField(
                    controller: controller.password,
                    hintText: 'Mật khẩu',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // repassword textfield
                  MyTextField(
                    controller: controller.repass,
                    hintText: 'Xác nhận mật khẩu',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    text: 'Đăng ký',
                    onTap: signUserUp,
                  ),

                  const SizedBox(height: 30),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                          // onTap: () {},
                          onTap: () => AuthService().signInWithGoogle(),
                          imagePath: 'images/google.png'),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bạn đã có sẵn tài khoản?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              type: PageTransitionType
                                  .rightToLeft, // Animation direction
                              child: LoginPage(), // Your next page widget
                            ),
                          );
                        },
                        child: const Text(
                          'Đăng nhập ngay',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
