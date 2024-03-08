import 'package:carousel_slider/carousel_slider.dart';
import 'package:do_thi_thong_minh/constants/square_tile.dart';
import 'package:do_thi_thong_minh/controller/home_controller.dart';
import 'package:do_thi_thong_minh/pages/profile_page/profile_page_2.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/form_reflect_page/form_reflect_page.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/reflect_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.controllerCarouselSlider,
  });

  final HomeController controllerCarouselSlider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: [
            // header image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
              height: 200,
              enlargeCenterPage: false,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              //autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controllerCarouselSlider.updatePageIndicator(index)),
        ),
        SizedBox(height: 5),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 2; i++)
                Container(
                  width: 15,
                  height: 3,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color:
                          controllerCarouselSlider.carousalCurrentIndex.value ==
                                  i
                              ? Colors.blue
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                )
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
            'Dịch vụ đô thị',
            style: GoogleFonts.notoSans(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReflectPage(),
                    )
                );
                print('4');
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      FontAwesomeIcons.warning,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Phản ánh')
                ],
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage2(),
                    )
                );
                print('5');
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      FontAwesomeIcons.qrcode,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('QRRRR')
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
