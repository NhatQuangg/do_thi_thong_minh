import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/pages/home_page/home_page.dart';
import 'package:do_thi_thong_minh/pages/profile_page/profile_page.dart';
import 'package:do_thi_thong_minh/repository/authentication/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class HomeBottomNavbar extends StatefulWidget {
  const HomeBottomNavbar({
    super.key,
  });

  @override
  State<HomeBottomNavbar> createState() => _HomeBottomNavbarState();
}

class _HomeBottomNavbarState extends State<HomeBottomNavbar> {
  // final auth = AuthenticationRepository.instance;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      // notchMargin: 5.0,
      shape: CircularNotchedRectangle(),
      color: mainColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push (
                PageTransition(
                  type: PageTransitionType.rightToLeft, // Animation direction
                  child: ProfilePage(), // Your next page widget
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).pushReplacement (
          //       PageTransition(
          //         type: PageTransitionType.rightToLeft, // Animation direction
          //         child: HomePage(), // Your next page widget
          //       ),
          //     );
          //   },
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(
          //         Icons.home,
          //         color: Colors.white,
          //         size: 30,
          //       ),
          //     ],
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              // Xử lý khi nút được nhấn
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Đăng xuất");
              //FirebaseAuth.instance.signOut();
              signOut();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.rightFromBracket,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
