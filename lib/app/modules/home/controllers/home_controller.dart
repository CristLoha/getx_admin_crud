import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_admin_crud/app/models/users.dart';

class HomeController extends GetxController {
  RxBool isApproved = true.obs;
  RxBool isActive = false.obs;
  RxBool isUnprov = false.obs;
  UserD userD = UserD();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void approve() {
    update();
  }

  Future<void> updateData(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).update(data!);
  }

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference users = firestore.collection('users');
    return users.get();
  }

  // Stream<QuerySnapshot<Object?>> streamData() {
  //   CollectionReference users = firestore.collection('users');
  //   return users.snapshots();
  // }
}
