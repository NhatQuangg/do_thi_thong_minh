import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/page/reflect/form_reflect_page/form_reflect_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_2/individual_screen.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_1/general_page.dart';
import 'package:flutter/material.dart';

class ReflectScreen extends StatefulWidget {
  const ReflectScreen({super.key});

  @override
  State<ReflectScreen> createState() => _ReflectScreenState();
}

class _ReflectScreenState extends State<ReflectScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            GeneralPage(),
            IndividualScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormReflectPage()),
            ).then((value) {
              setState(() {});
            });
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: kPrimaryColor,
          // elevation: 0,
          shape: CircleBorder(),
        ),
        bottomNavigationBar: Container(
          height: 50,
          color: Colors.white,
          child: TabBar(
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
            unselectedLabelColor: kBorderColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topRight: _currentIndex == 0
                    ? Radius.circular(50) : Radius.zero,
                topLeft: _currentIndex == 1
                    ? Radius.circular(50) : Radius.zero,
              )
            ),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: [
              Tab(text: 'Chung'),
              Tab(text: 'Cá nhân')
            ],
          ),
        ),
      ),
    );
  }
}
