import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime today = DateTime.now();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTask() async* {
    yield* firestore
        .collection("task")
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPlanToday() async* {
    DateTime startTime = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endTime = DateTime(today.year, today.month, today.day, 23, 59, 59);

    yield* firestore
        .collection("plan")
        .where('planAt',
            isGreaterThanOrEqualTo: startTime.toIso8601String(),
            isLessThanOrEqualTo: endTime.toIso8601String())
        .limit(1)
        .snapshots();
  }

  @override
  void onInit() {
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
