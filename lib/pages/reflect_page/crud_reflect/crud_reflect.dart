import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CrudReflect {
  Future<void> addData(reflectData) async {
    FirebaseFirestore.instance
        .collection("reflect")
        .add(reflectData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("reflect").snapshots();
  }
}
