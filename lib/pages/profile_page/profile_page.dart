import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/constants/global.dart';
import 'package:do_thi_thong_minh/constants/text_box.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/pages/home_page/components/home_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final controller = Get.put(ProfileController());
  final idemail = getEmail();

  final auth = FirebaseAuth.instance;

  // -------------------------------------------------------------
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  final currentPassword = FirebaseAuth.instance.currentUser!.email;
  
  String oldPass = "";
  String currentPasswordd = "";

  // edit field

  // Future<void> editFieldd(String field) async {
  //
  //   String newValue = "";
  //   await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         backgroundColor: Colors.white,
  //         title: Text(
  //           'Edit ' + field,
  //           style: TextStyle(color: Colors.grey[900]),
  //         ),
  //         content: TextField(
  //           autofocus: true,
  //           style: TextStyle(
  //             color: Colors.grey[900],
  //           ),
  //           decoration: InputDecoration(
  //               hintText: "Enter new $field",
  //               hintStyle: TextStyle(color: Colors.grey)
  //           ),
  //           onChanged: (value) {
  //             newValue = value;
  //             print('gia tri thay vo: $newValue');
  //           },
  //         ),
  //         actions: [
  //
  //           // cancel button
  //           TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text(
  //                 'Cancel',
  //                 style: TextStyle(color: Colors.grey[900]),
  //               )),
  //
  //           // save button
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(newValue),
  //             child: Text(
  //               'Save',
  //               style: TextStyle(color: Colors.grey[900]),
  //             )
  //           )
  //         ],
  //       )
  //   );
  //
  // }


  Future<void> editField(String field, String idUser) async {
    
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Edit ' + field,
                style: TextStyle(color: Colors.grey[900]),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(
                  color: Colors.grey[900],
                ),
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                  hintStyle: TextStyle(color: Colors.grey)
                ),
                onChanged: (value) {
                  newValue = value;
                  print('gia tri thay vo: $newValue');
                },
              ),
              actions: [

                // cancel button
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[900]),
                    )),

                // save button
                TextButton(
                    onPressed: () async {
                      print("field moi: ${newValue}");
                      print("id: ${currentUser.uid}");
                      // update in firestore
                      if (newValue.trim().length > 0) {
                        // only update if there is S.T in the textfield
                        await usersCollection
                            .doc(idUser)
                            .update({field: newValue});
                        print('Đã cập nhật profile');
                        showSuccessSnackBar("Cập nhật thành công!");
                        Navigator.of(context).pop(newValue);
                        setState(() {});

                      } else {
                        showErrorSnackBar("Không được để trống");
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.grey[900]),
                    ))
              ],
            ));
  }

  // Future<void> updatePassword(String field, String currentPass) async {
  //   String newPass = "";
  //   await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             backgroundColor: Colors.white,
  //             title: Text(
  //               'Edit ' + field,
  //               style: TextStyle(color: Colors.grey[900]),
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 TextField(
  //                   autofocus: true,
  //                   style: TextStyle(
  //                     color: Colors.grey[900],
  //                   ),
  //                   decoration: InputDecoration(
  //                       hintText: "Enter new old pass",
  //                       hintStyle: TextStyle(color: Colors.grey)),
  //                   onChanged: (value1) {
  //                     oldPass = value1;
  //                   },
  //                 ),
  //                 TextField(
  //                   // autofocus: true,
  //                   style: TextStyle(
  //                     color: Colors.grey[900],
  //                   ),
  //                   decoration: InputDecoration(
  //                       hintText: "Enter new new pass",
  //                       hintStyle: TextStyle(color: Colors.grey)),
  //                   onChanged: (value) {
  //                     newPass = value;
  //                   },
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               // cancel button
  //               TextButton(
  //                   onPressed: () => Navigator.pop(context),
  //                   child: Text(
  //                     'Cancel',
  //                     style: TextStyle(color: Colors.grey[900]),
  //                   )),
  //
  //               // save button
  //               TextButton(
  //                   // onPressed: () => Navigator.of(context).pop(newPass),
  //                   onPressed: () async {
  //                     print(currentPass + "  " + oldPass);
  //                     if (currentPass == oldPass) {
  //                       User? user = FirebaseAuth.instance.currentUser;
  //                       try {
  //                         var credential = EmailAuthProvider.credential(
  //                           email: user!.email!,
  //                           password: currentPass,
  //                         );
  //                         await user.reauthenticateWithCredential(credential);
  //
  //                         await user.updatePassword(newPass);
  //
  //                         // update in firestore
  //                         if (newPass.trim().length > 0) {
  //                           await usersCollection
  //                               .doc(currentUser.email)
  //                               .update({field: newPass});
  //                           print('Đã cập nhật profile');
  //                         }
  //                         showSuccessSnackBar("Cập nhật mật khẩu thành công!");
  //                         print('Đã đổi mật khẩu thành công!');
  //
  //                         // Cập nhật giá trị mới vào TextField
  //                         setState(() {
  //                           currentPasswordd = newPass;
  //                         });
  //                       } catch (e) {
  //                         showErrorSnackBar("Mật khẩu quá yếu (>=6 kí tự)");
  //                         print('Lỗi khi đổi mật khẩu: $e');
  //                         // Xử lý lỗi tại đây
  //                       }
  //                     } else {
  //                       print('Mật khẩu hiện tại không đúng!');
  //                       showErrorSnackBar("Mật khẩu hiện tại không đúng!");
  //                     }
  //
  //                     Navigator.pop(context, newPass);
  //                   },
  //                   child: Text(
  //                     'Save',
  //                     style: TextStyle(color: Colors.grey[900]),
  //                   ))
  //             ],
  //           ));
  //
  //   // print(currentPass + "  " + oldPass);
  //   // if (currentPass == oldPass) {
  //   //   User? user = FirebaseAuth.instance.currentUser;
  //   //   try {
  //   //     var credential = EmailAuthProvider.credential(
  //   //       email: user!.email!,
  //   //       password: currentPass,
  //   //     );
  //   //     await user.reauthenticateWithCredential(credential);
  //   //
  //   //     await user.updatePassword(newPass);
  //   //
  //   //     print('Đã đổi mật khẩu thành công!');
  //   //   } catch (e) {
  //   //     print('Lỗi khi đổi mật khẩu: $e');
  //   //   }
  //   // } else {
  //   //   print('Mật khẩu hiện tại không đúng!');
  //   // }
  // }

  void showSuccessSnackBar(String message) {
    AnimatedSnackBar.material(message,
            type: AnimatedSnackBarType.success,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(context);
  }

  void showErrorSnackBar(String message) {
    AnimatedSnackBar.material(message,
            type: AnimatedSnackBarType.error,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 25,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'THÔNG TIN CÁ NHÂN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // get user data
                if (snapshot.hasData) {
                  // final userDataa = snapshot.data!.data() as Map<String, dynamic>;

                  // final userData = userDataa.map((key, value) => MapEntry(key, value.toString()));
                  // currentPasswordd = userData['password'] ?? "";
                  // print("mat khau htai: " + currentPasswordd);

                  // final userData = snapshot.data!.data();
                  UserModel user = snapshot.data as UserModel;
                  print("email: ${user.email} , ${user.fullName}, ${user.id}" );
                  return Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),

                      // profile pic
                      const Icon(
                        Icons.person,
                        size: 90,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // user email
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // user detail
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Thông tin chi tiết',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),

                      // fullname
                      MyTextBox(
                        text: user.fullName ?? "",
                        sectionName: 'fullname',
                        onPressed: () => editField('fullName', user.id.toString()),
                      ),

                      // MyTextBox(
                      //   text: user.fullName ?? "",
                      //   sectionName: 'fullName',
                      //   onPressed: () => editFieldd('fullName'),
                      // ),

                      // phone
                      MyTextBox(
                        text: user.phoneNo ?? "",
                        sectionName: 'phone',
                        onPressed: () => editField('phone', user.id.toString()),
                      ),

                      // pass
                      // MyTextBox(
                      //   text: userDataa['password'] ?? "",
                      //   sectionName: 'password',
                      //   onPressed: () => updatePassword('password', currentPasswordd),
                      // ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error ${snapshot.error}'),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      // bottomNavigationBar: HomeBottomNavbar(),
    );
  }
}
