import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:do_thi_thong_minh/constants/my_button.dart';
import 'package:do_thi_thong_minh/constants/my_textfield.dart';
import 'package:do_thi_thong_minh/constants/square_tile.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/pages/login_page/auth_page.dart';
import 'package:do_thi_thong_minh/pages/register_page/register_page.dart';
import 'package:do_thi_thong_minh/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  // final Function()? onTap;
  // const LoginPage({Key? key, required this.onTap});

  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;

  // sign user in method
  void signUserIn() async {
    // try sign in
    try {
      // check username null
      if (emailController.text == null || emailController.text == "") {
        AnimatedSnackBar.material("Vui lòng nhập email!",
                type: AnimatedSnackBarType.error,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(context);
        print('chua nhap email');
      } else if (passwordController.text == null || passwordController.text == "") {
        AnimatedSnackBar.material('Vui lòng nhập mật khẩu!',
                type: AnimatedSnackBarType.error,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(context);
        print('chua nhap mk');
      } else {
        print("Đăng nhập thành công 1");
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return const Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // Navigator.pop(context);
        // Navigator.of(context).pop();
        Future.delayed(const Duration(seconds: 0), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AuthPage()),
          );
        });
        // Navigator.pop(context);
        print('Đăng nhập thành công 2');
      }
    } on FirebaseAuthException catch (e) {
      print("Looix: ${e.message}");
      if (e.message ==
          'An unknown error occurred: FirebaseError: Firebase: The email address is badly formatted. (auth/invalid-email).') {
        AnimatedSnackBar.material('Mật khẩu không đúng. Vui lòng thử lại!',
            type: AnimatedSnackBarType.error,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(context);
        print('mk sai');
      } else if (e.message ==
          'The supplied auth credential is incorrect, malformed or has expired.') {
        AnimatedSnackBar.material('Tài khoản không đúng. Vui lòng thử lại!',
            type: AnimatedSnackBarType.error,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(context);
        print('email sai');

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ĐĂNG NHẬP',
                  style: GoogleFonts.roboto(
                      color: Color(0xFF109ea2),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Tên đăng nhập',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // MyTextField(
                //   controller: passwordController,
                //   hintText: 'Mật khẩu',
                //   obscureText: true,
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () async {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.all(Radius.circular(30.0))),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Mật khẩu',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w100,
                          fontSize: 15,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0)
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Quên mật khẩu?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // sign in button
                MyButton(
                  text: 'Đăng nhập',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
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
                const SizedBox(height: 50),
                // google sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        // onTap: () {},
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'images/google.png'),
                  ],
                ),
                const SizedBox(height: 50),
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn chưa có tài khoản?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushReplacement (
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft, // Animation direction
                        //     child: RegisterPage(), // Your next page widget
                        //   ),
                        // );
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                      child: const Text(
                        'Đăng ký ngay',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

