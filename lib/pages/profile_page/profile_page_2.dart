import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/constants/global.dart';
import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({super.key});

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  final controller = Get.put(ProfileController());
  final idemail = getEmail();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )
        ),
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final fullName = TextEditingController(text: user.fullName);
                  final phoneNo = TextEditingController(text: user.phoneNo);
                  // final role = TextEditingController(text: user.level);

                  final id = TextEditingController(text: user.id);
                  String idUser = id.text;

                  print("hehe : ${user.email}");

                  print("USER PROFILE == $email $password $fullName $phoneNo $idUser");
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 5.0, right: 0.0, bottom: 0.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey
                          ),
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: TextFormField(
                                controller: email,
                                obscureText: false,
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: 'Nhập email người dùng...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.5,),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.5,),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // filled: true,
                                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                ),
                                maxLines: null,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Họ và tên",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: TextFormField(
                                controller: fullName,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Nhập tên người dùng...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0
                                    )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kBorderColor,
                                        width: 1.0
                                    )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1,),
                                      borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1,),
                                      borderRadius: BorderRadius.circular(8),
                                  ),
                                  // filled: true,
                                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                ),
                                maxLines: null,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                             "Số điện thoại",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: TextFormField(
                                controller: phoneNo,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Chưa cập nhật...' /* Enter your email... */,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kBorderColor,
                                      width: 1.0
                                    )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // filled: true,
                                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                ),
                                maxLines: null,
                                ),
                              ),
                            SizedBox(height: 10),
                            Text(
                              "Mật khẩu",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: TextFormField(
                                controller: password,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Mật khẩu' /* Enter your email... */,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0
                                    )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kBorderColor,
                                        width: 1.0
                                    )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // filled: true,
                                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                ),
                                maxLines: null,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        )
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () async {
                          final userData = UserModel(
                            id: idUser,
                            fullName: fullName.text.trim(),
                            email: email.text.trim(),
                            phoneNo: phoneNo.text.trim(),
                            password: password.text.trim(),
                            level: '1',
                          );
                          await controller.updateRecord(userData).then((value) {
                            AnimatedSnackBar.material(
                              "Cập nhật thành công",
                              type: AnimatedSnackBarType.success,
                              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                              // duration: Duration(milliseconds: 1),
                            ).show(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                        ),
                        child: Text(
                          "Cập nhật thông tin",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}
