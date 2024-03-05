import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/controller/home_controller.dart';
import 'package:do_thi_thong_minh/pages/home_page/components/home_body.dart';
import 'package:do_thi_thong_minh/pages/home_page/components/home_bottom_navbar.dart';
import 'package:do_thi_thong_minh/pages/home_page/components/qr_code_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final controllerCarouselSlider = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: HomeBody(controllerCarouselSlider: controllerCarouselSlider),
      bottomNavigationBar: HomeBottomNavbar(),
    );
  }
}
