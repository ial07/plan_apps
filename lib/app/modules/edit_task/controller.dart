import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';

class EditTaskController extends GetxController with MainController {
  Map<String, dynamic> data = Get.arguments;
  final GlobalKey<FormState> formTask = GlobalKey<FormState>();
  TextEditingController kegiatan = TextEditingController();
  TextEditingController qty = TextEditingController();
  RxString dropdownValue = "".obs;
  RxBool isLoading = false.obs;
  RxMap error = {}.obs;
  RxString dropdownValueErr = "".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  var image = Rx<XFile?>(null);
  final ImagePicker pickImg = ImagePicker();

  Future<XFile?> imagePicker() async {
    image.value = await pickImg.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    isLoading.value = true;
    if (image.value != null) {
      isLoading.value = false;
      return image.value;
    } else {
      isLoading.value = false;
    }
    update();
  }

  removeImage() {
    image.value = null;
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

    if (kegiatan.text.isNotEmpty && dropdownValue.isNotEmpty) {
      try {
        if (auth.currentUser != null) {
          var date = DateTime.now().toIso8601String();
          String uid = auth.currentUser!.uid;
          String username = getFirstWord(auth.currentUser!.displayName!);
          if (image.value != null) {
            File file = File(image!.value!.path);
            String ext = image!.value!.name.split(".").last;

            await storage
                .ref("${dropdownValue.value}/${data["createdAt"]}.${ext}")
                .putFile(file);
            String UrlImage;
            if (data["opsi"] == "panen" || data["opsi"] == "menanam") {
              UrlImage = await storage
                  .ref("${dropdownValue.value}/${data["createdAt"]}.${ext}")
                  .getDownloadURL();
            } else {
              UrlImage = "";
            }

            await firestore
                .collection("task")
                .where("createdAt", isEqualTo: data["createdAt"])
                .get()
                .then((value) {
              value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection("task")
                    .doc(element.id)
                    .update({
                  "kegiatan": kegiatan.text,
                  "qty": qty.text,
                  "opsi": dropdownValue.value,
                  "photoUrl": UrlImage,
                  "UpdatedAt": date
                });
              });
            });
          } else {
            await firestore
                .collection("task")
                .where("createdAt", isEqualTo: data["createdAt"])
                .get()
                .then((value) {
              value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection("task")
                    .doc(element.id)
                    .update({
                  "kegiatan": kegiatan.text,
                  "qty": qty.text,
                  "opsi": dropdownValue.value,
                  "UpdatedAt": date
                });
              });
            });
          }

          Get.offAllNamed(Routes.HOME);
          SnackbarFunction.snackBarSuccess("Berhasil mengedit kegiatan");
        } else {
          SnackbarFunction.snackBarError("Gagal mengedit kegiatan");
        }
      } catch (e) {
        SnackbarFunction.snackBarError("Gagal mengedit kegiatan");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    kegiatan.text = data["kegiatan"];
    data["qty"] != null ? qty.text = data["qty"] : null;
    dropdownValue.value = data["opsi"];
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
