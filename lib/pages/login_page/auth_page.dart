import 'package:do_thi_thong_minh/pages/home_page/home_page.dart';
import 'package:do_thi_thong_minh/pages/login_page/login_or_register_page.dart';
import 'package:do_thi_thong_minh/pages/login_page/login_page.dart';
import 'package:do_thi_thong_minh/pages/register_page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  // final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            // doi du lu ve trang thai login
            return CircularProgressIndicator();
          }
          else if (snapshot.hasData) {
            final user = snapshot.data!;
            // print("chuyen qua trang home ${user.email!}");
            return HomePage();
          }
          else {
            return LoginPage();
          }
          // if(snapshot.hasData) {
          //   // user is logged in
          //   print('chuyen qua trang home ' + user.email!);
          //   return HomePage();
          // }
          // // user is not logged in
          // else {
          //   return LoginPage();
          // }
        },
      ),
    );
  }
}
