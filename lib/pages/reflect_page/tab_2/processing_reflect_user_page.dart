import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/constants/icon_text.dart';
import 'package:do_thi_thong_minh/constants/utils.dart';
import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/controller/reflect_controller.dart';
import 'package:do_thi_thong_minh/model/reflect_model.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/tab_1/all_reflect_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ProcessingReflectUserPage extends StatefulWidget {
  const ProcessingReflectUserPage({super.key});

  @override
  State<ProcessingReflectUserPage> createState() => _ProcessingReflectUserPageState();
}

class _ProcessingReflectUserPageState extends State<ProcessingReflectUserPage> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  List<dynamic> dataList = [];

  void delete(String id) {
    FirebaseFirestore.instance.collection("Reflects").doc(id).delete();
    AnimatedSnackBar.material(
      'Xóa phản ánh thành công!',
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.all(12),
                child: FutureBuilder<List<ReflectModel>>(
                  future: controller.getProcessingReflectUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime date = DateTime.parse(snapshot.data![index].createdAt!
                                .toDate()
                                .toString()
                            );
                            String formatedDate = DateFormat('dd/MM/yyyy').format(date);
                            // String formatedDate = DateFormat.yMd().format(date);
                            int? handle = snapshot.data![index].handle;
                            String file = getFileName("${snapshot.data?[index].media?[0]}");

                            print('${snapshot.data![index].media}');
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) async {
                                        delete(snapshot.data![index].id!);
                                        setState(() {});
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      // label: 'DELETE',
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           DetailReflectUserPage(reflect: snapshot.data![index],)
                                    //   ),
                                    // ).then((value) {
                                    //   setState(() {});
                                    // });
                                  },
                                  child: Container(
                                    height: 125,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 6,
                                          color: Color(0x34000000),
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        isImageFromPath(file.split('.').last)
                                            ? Padding(
                                          padding: const EdgeInsets.only(left: 7),
                                          child: Container(
                                            width: 110,
                                            height: 106,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    "${snapshot.data![index].media![0]}",
                                                  ).image
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                        )
                                            : Center(child: CircularProgressIndicator()),

                                        // Container(
                                        //   width: 130,
                                        //   height: 110,
                                        //   decoration: BoxDecoration(
                                        //     color: Color(0xFFEEEEEE),
                                        //     image: DecorationImage(
                                        //       fit: BoxFit.cover,
                                        //       image: Image.network(
                                        //           '${snapshot.data![index].media}'
                                        //       ).image,
                                        //     ),
                                        //     borderRadius: BorderRadius.circular(8),
                                        //     border: Border.all(
                                        //       color: Color(0xFF656565),
                                        //       width: 0.5,
                                        //     ),
                                        //   ),
                                        // ),

                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                child: Text(
                                                  '${snapshot.data![index].title}',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                height: 50,
                                                child: Text(
                                                  '${snapshot.data![index].content}',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              //padding: EdgeInsets.all(0),
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    iconAndText(
                                                        textStyle: TextStyle(fontSize: 12),
                                                        size: 12,
                                                        title: formatedDate,
                                                        icon: Icons.calendar_month
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2,),
                                            Padding(
                                              //padding: EdgeInsets.all(0),
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    iconAndText(
                                                        textStyle: TextStyle(
                                                            fontSize: 12
                                                        ),
                                                        size: 12,
                                                        title: '${snapshot.data![index].category}',
                                                        icon: Icons.bookmark
                                                    ),
                                                    if (handle == 1)
                                                      Text(
                                                        'Đang xử lý',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.red
                                                        ),
                                                      )
                                                    else if (handle == 0)
                                                      Text(
                                                        'Đã xử lý',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.blue
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
