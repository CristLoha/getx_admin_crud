import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:getx_admin_crud/app/models/users.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pemohon'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.active) {
            var listAllDocs = snap.data!.docs;

            return ListView.builder(
                itemCount: listAllDocs.length,
                itemBuilder: (context, index) {
                  UserD userD = UserD.fromJson(
                      snap.data!.docs[index].data() as Map<String, dynamic>);
                  return ListTile(
                    title: Text(
                        "${(listAllDocs[index].data() as Map<String, dynamic>)["name"]}"),
                    subtitle: Text(
                        "${(listAllDocs[index].data() as Map<String, dynamic>)["email"]}"),
                    trailing: userD.approved == true
                        ? ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {
                              EasyLoading.show();
                              controller.updateData(
                                data: {
                                  'approved': false,
                                },
                                docName: userD.id,
                                reference: controller.users,
                              ).then(
                                (value) => EasyLoading.dismiss(),
                              );
                            },
                            child: const Text('Reject'),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              EasyLoading.show();
                              controller.updateData(
                                data: {
                                  'approved': true,
                                },
                                docName: userD.id,
                                reference: controller.users,
                              ).then(
                                (value) => EasyLoading.dismiss(),
                              );
                            },
                            child: const Text('Approved')),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
