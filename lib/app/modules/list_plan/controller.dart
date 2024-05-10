import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListPlanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime today = DateTime.now();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPlan() async* {
    DateTime startTime = DateTime(today.year, today.month, today.day, 0, 0, 0);
    yield* firestore
        .collection("plan")
        .orderBy('planAt')
        .where("planAt", isGreaterThan: startTime.toIso8601String())
        .limit(30)
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
