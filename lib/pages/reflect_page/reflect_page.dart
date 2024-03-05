import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/form_reflect_page/form_reflect_page.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/tab1.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/tab2.dart';
import 'package:flutter/material.dart';

class ReflectPage extends StatefulWidget {
  const ReflectPage({super.key});

  @override
  State<ReflectPage> createState() => _ReflectPageState();
}

class _ReflectPageState extends State<ReflectPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            tab1(),
            tab2(),
            // GeneralPage(),
            // IndividualScreen(),
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
          backgroundColor: mainColor,
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
              color: mainColor,
              borderRadius: BorderRadius.only(
                topRight: _currentIndex == 0
                    ? Radius.circular(30) : Radius.zero,
                topLeft: _currentIndex == 1
                    ? Radius.circular(30) : Radius.zero,
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
