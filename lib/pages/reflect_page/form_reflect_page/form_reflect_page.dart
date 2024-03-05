import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/constants/global.dart';
import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/controller/reflect_controller.dart';
import 'package:do_thi_thong_minh/model/reflect_model.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/crud_reflect/camera_reflect.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/crud_reflect/colors.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/crud_reflect/crud_reflect.dart';
import 'package:do_thi_thong_minh/pages/reflect_page/crud_reflect/full_screen_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:random_string/random_string.dart';

class FormReflectPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => FormReflectPage(),
      );
  const FormReflectPage({super.key});

  @override
  State<FormReflectPage> createState() => FormReflectPageState();
}

class FormReflectPageState extends State<FormReflectPage> {
  final controllerUer = Get.put(ProfileController());
  List<File> listFile = [];

  String? authorName, title, desc;
  CrudReflect crudReflect = new CrudReflect();
  // final FirebaseStorage storage = FirebaseStorage.instance;
  QuerySnapshot? refSnapshot;
  // List<ReflectModel> reflect = List.empty(growable: true);
  bool accept = false;
  String? url;
  File? image;
  List<String> urls = [];
  List<String> video_urls = [];
  List<String> listCategory = ['Giáo dục', 'An ninh', 'Cơ sở vật chất'];
  String? selectNameCategogy;

  bool _isloading = false;
  String imageUrl = '';
  XFile? file;
  String? u;
  String slectedFileName = "";
  String defaultImageUrl =
      'https://hanoispiritofplace.com/wp-content/uploads/2014/08/hinh-nen-cac-loai-chim-dep-nhat-1-1.jpg';

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("failed to picker image: $e");
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        // backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () {
                    _selectFile(true);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("Camera"),
                  onTap: () {
                    // _selectFile(false);
                    _selectImgVideo(false);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
        });
  }

  _selectFile(bool imageFrom) async {
    file = await ImagePicker().pickImage(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);

    if (file != null) {
      setState(() {
        slectedFileName = file!.name;
      });
    }
    print(file!.name);
  }

  _selectImgVideo(bool imageFrom) async {
    file = await ImagePicker().pickVideo(
        source: imageFrom ? ImageSource.gallery : ImageSource.camera);

    if (file != null) {
      setState(() {
        slectedFileName = file!.name;
      });
    }
    print(file!.name);
  }

  Future<void> uploadImages() async {
    int i = -1;

    for (File imageFile in listFile) {
      i++;

      try {
        firebase_storage.UploadTask uploadTask;

        var ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('ListingImages')
            .child(randomAlpha(9) + "${listFile[i].path}");

        // await ref.putFile(imageFile);
        uploadTask = ref.putFile(listFile[i]);
        final snapshot = await uploadTask.whenComplete(() => null);
        u = await snapshot.ref.getDownloadURL();
        print("URLLL == $u");
        urls.add(u!);
      } catch (err) {
        print(err);
      }
    }
    print(listFile);
  }

  _uploadFile() async {
    try {
      firebase_storage.UploadTask uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Images')
          .child('/' + file!.name);

      // uploadTask = ref.putFile(File(file!.path));
      uploadTask = ref.putFile(File(file!.path));

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      print('UPLOAD IMAGE URL' + imageUrl);

    } catch (e) {
      print(e);
    }
  }

  final controller = Get.put(ReflectController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("CATEGOGY == ${selectNameCategogy}");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineAwesomeIcons.angle_left)),
        title: Text(
          "Đăng phản ánh",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          const SizedBox(height: 8,),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                TitleReflect(title: "Tiêu đề"),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: controller.title,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey.shade400),
                                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                                        ),
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        hintText: "Nhập tiêu đề ...",
                                        hintStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15,
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15)
                                    ),
                                    maxLines: null,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                TitleReflect(title: "Lĩnh vực"),
                                const SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 1, color: Colors.grey)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: EdgeInsets.zero,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Transform.translate(
                                          offset: Offset(-10, 0),
                                          child: Text(
                                            selectNameCategogy ??
                                                listCategory[0],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        items: listCategory
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Transform.translate(
                                                    offset: Offset(-10, 0),
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectNameCategogy,
                                        onChanged: (value) {
                                          setState(() {
                                            selectNameCategogy =
                                                value as String?;
                                            if (value == listCategory[0]) {
                                              selectNameCategogy =
                                                  listCategory[0];
                                            }
                                            if (value == listCategory[1]) {
                                              selectNameCategogy =
                                                  listCategory[1];
                                            }
                                            if (value == listCategory[2]) {
                                              selectNameCategogy =
                                                  listCategory[2];
                                            }
                                          });
                                        },
                                        // buttonHeight: 30,
                                        // itemHeight: 40,
                                        // dropdownMaxHeight: 200,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 15),

                                TitleReflect(title: "Nội dung"),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: controller.content,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey.shade400),
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      hintText: "Nhập nội dung ...",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    ),
                                    maxLines: 11,

                                  ),
                                ),

                                const SizedBox(height: 15,),

                                TitleReflect(title: "Vị trí"),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: TextFormField(
                                    controller: controller.address,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey.shade400),
                                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      hintText: "Nhập địa chỉ ...",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    ),
                                    maxLines: null,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                TitleReflect(title: "Ảnh, video"),
                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context, rootNavigator: true)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              // CameraStageScreen(this),
                                              CameraGuiPhanAnhScreen(this),
                                        ));
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        dashPattern: [3, 3, 3, 3],
                                        color: AppColors.dottedColorBorder,
                                        radius: Radius.circular(8),
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          child: Center(
                                            child:
                                              Icon(Icons.image_outlined)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 100,
                                        width: 220,
                                        child: ListView.separated(
                                          itemCount: listFile.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            width: 20,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            print(
                                                "IMAGE == ${listFile[index].path}");

                                            if (listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("jpg") ||
                                                listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("png") ||
                                                listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("jpeg") ||
                                                listFile[index]
                                                    .path
                                                    .toLowerCase()
                                                    .contains("webp")) {
                                              print(
                                                  "file ${listFile[index].path}");
                                              return Stack(
                                                children: [
                                                  FullScreenWidget(
                                                    child: Center(
                                                      child: Hero(
                                                        tag: "guiphananh",
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.file(
                                                            listFile[index],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          listFile.remove(
                                                              listFile[index]);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              print(
                                                  "file ${listFile[index].path}");
                                              return Stack(
                                                children: [
                                                  Platform.isIOS
                                                      ? Container(
                                                          height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          199,
                                                                          202,
                                                                          204)),
                                                          child: Icon(
                                                            Icons
                                                                .video_collection,
                                                            color: Colors.white,
                                                            size: 30,
                                                          ),
                                                        )
                                                      : Container( ),
                                                  Positioned(
                                                    top: 5,
                                                    left: 5,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          listFile.remove(
                                                              listFile[index]);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 30,),
                                Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 300,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          print("TITLE == ${controller.title.text}");

                                          if (controller.title.text.trim() == null ||
                                              controller.title.text.trim() == "") {

                                            AnimatedSnackBar.material(
                                              'Chưa nhập tiêu đề!',
                                              duration: Duration(milliseconds: 1),
                                              type: AnimatedSnackBarType.error,
                                              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                                            ).show(context);
                                            print("ok 1");
                                            return null;
                                          } else {
                                            setState(() {
                                              _isloading = true;
                                            });
                                            await uploadImages();
                                            await ReflectController.instance
                                                .createReflect(ReflectModel(
                                                    content_response: '',
                                                    // likes: [],
                                                    email: getEmail(),
                                                    title: controller.title.text.trim(),
                                                    category: selectNameCategogy,
                                                    content: controller.content.text.trim(),
                                                    address: controller.address.text.trim(),
                                                    media: urls,
                                                    accept: false,
                                                    handle: 1,
                                                    createdAt: Timestamp.now()))
                                                .then((value) {

                                              AnimatedSnackBar.material(
                                                'Đăng phản ánh thành công!',
                                                type: AnimatedSnackBarType.success,
                                                duration: Duration(milliseconds: 1),
                                                mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                                              ).show(context);
                                              controller.title.text = '';
                                              // selectNameCategogy = '';
                                              controller.content.text = '';
                                              controller.address.text = '';
                                              listFile = [];
                                              setState(() {
                                                _isloading = false;
                                              });
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber),
                                        child: Text(
                                          "Đăng phản ánh",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 60,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class TitleReflect extends StatelessWidget {
  String title;
  bool isRequired = true;
  TitleReflect({Key? key, required this.title, this.isRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        isRequired
            ? Text(
                '*',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            : SizedBox()
      ],
    );
  }
}
