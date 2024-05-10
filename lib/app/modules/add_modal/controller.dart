import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';

class AddModalController extends GetxController with MainController {
  TextEditingController keterangan = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController harga = TextEditingController();

  RxBool isLoading = false.obs;
  RxMap error = {}.obs;
  RxString dropdownValueErr = "".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> processSubmit() async {
    print("object");
    var Amount = harga.text.replaceAll("Rp. ", "").replaceAll(".", "");
    isLoading.value = true;
    if (keterangan.text.isEmpty) {
      isLoading.value = false;
      error["keterangan"] = "Harap isi keterangan";

      Future.delayed(Duration(seconds: 5), () {
        error["keterangan"] = null;
      });
    }
    if (qty.text.isEmpty) {
      isLoading.value = false;
      error["qty"] = "Harap isi qty";

      Future.delayed(Duration(seconds: 5), () {
        error["qty"] = null;
      });
    }
    if (harga.text.isEmpty) {
      isLoading.value = false;
      error["harga"] = "Harap isi harga";

      Future.delayed(Duration(seconds: 5), () {
        error["harga"] = null;
      });
    }
    if (keterangan.text.isNotEmpty &&
        Amount.isNotEmpty &&
        qty.text.isNotEmpty) {
      try {
        if (auth.currentUser != null) {
          var dates = DateTime.now().toIso8601String();
          String uid = auth.currentUser!.uid;
          String username = getFirstWord(auth.currentUser!.displayName!);

          await firestore.collection("modal").doc(dates).set({
            "uid": uid,
            "user": username,
            "keterangan": keterangan.text,
            "qty": qty.text,
            "amount": double.parse(Amount),
            "createdAt": dates,
          });

          Get.offAllNamed(Routes.LISTMODAL);
          SnackbarFunction.snackBarSuccess("Berhasil menambah modal");
        } else {
          SnackbarFunction.snackBarError("Gagal menambah modal");
        }
      } catch (e) {
        SnackbarFunction.snackBarError("Gagal menambah modal");
      } finally {
        isLoading.value = false;
      }
    }
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
