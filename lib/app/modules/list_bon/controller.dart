import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ListBonController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxDouble total = 0.0.obs;
  DateTime today = DateTime.now();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamBon() async* {
    yield* firestore
        .collection("bon")
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> sumAmounts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('bon')
        .where("status", isEqualTo: "belum lunas")
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data!.containsKey('amount')) {
        total.value += data['amount'] ?? 0;
      }
    }
  }

  @override
  void onInit() {
    sumAmounts();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
