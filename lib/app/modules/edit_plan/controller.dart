import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';

class EditPlanController extends GetxController with MainController {
  Map<String, dynamic> data = Get.arguments;
  TextEditingController kegiatan = TextEditingController();
  TextEditingController date = TextEditingController();
  String isoString = "";
  RxString dropdownValue = "".obs;
  RxBool isLoading = false.obs;
  RxMap error = {}.obs;
  RxString dropdownValueErr = "".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void choseeDate() async {
    DateTime? selectedDateTime;

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2080),
    );

    if (pickedDate != null && pickedDate != selectedDateTime) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        date.text =
            "${DateFormat("dd-MM-yyyy").format(pickedDate).toString() + " " + pickedTime.hour.toString() + ":" + pickedTime.minute.toString()}";

        isoString = selectedDateTime!.toIso8601String();
      }
    }
  }

  Future<void> processSubmit() async {
    isLoading.value = true;
    if (kegiatan.text.isEmpty) {
      isLoading.value = false;
      error["kegiatan"] = "Harap isi kegiatan";

      Future.delayed(Duration(seconds: 5), () {
        error["kegiatan"] = null;
      });
    }
    if (dropdownValue.isEmpty) {
      isLoading.value = false;
      error["opsi"] = "Harap isi jenis kegiatan";

      Future.delayed(Duration(seconds: 5), () {
        error["opsi"] = null;
      });
    }

    if (date.text.isEmpty && isoString == "") {
      isLoading.value = false;
      error["tanggal"] = "Harap isi tanggal";

      Future.delayed(Duration(seconds: 5), () {
        error["tanggal"] = null;
      });
    }

    if (kegiatan.text.isNotEmpty && dropdownValue.isNotEmpty) {
      try {
        if (auth.currentUser != null) {
          var dates = DateTime.now().toIso8601String();
          String uid = auth.currentUser!.uid;
          String username = getFirstWord(auth.currentUser!.displayName!);

          await firestore
              .collection("plan")
              .where("createdAt", isEqualTo: data["createdAt"])
              .get()
              .then((value) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("plan")
                  .doc(element.id)
                  .update({
                "kegiatan": kegiatan.text,
                "opsi": dropdownValue.value,
                "updatedAt": dates,
                "planAt": isoString
              });
            });
          });

          Get.offAllNamed(Routes.LISTPLAN);
          SnackbarFunction.snackBarSuccess(
              "Berhasil mengedit rencana kegiatan");
        } else {
          SnackbarFunction.snackBarError("Gagal mengedit rencana kegiatan");
        }
      } catch (e) {
        SnackbarFunction.snackBarError("Gagal mengedit rencana kegiatan");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    kegiatan.text = data["kegiatan"];
    dropdownValue.value = data["opsi"];
    date.text = DateFormat("dd-MM-yyyy")
        .format(DateTime.parse(data["planAt"]))
        .toString();
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
