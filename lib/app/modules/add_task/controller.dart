import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';

class AddTaskController extends GetxController with MainController {
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

    if (dropdownValue.value == "panen" && qty.text.isEmpty) {
      isLoading.value = false;
      error["qty"] = "Harap isi banyak panen";

      Future.delayed(Duration(seconds: 5), () {
        error["qty"] = null;
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
                .ref("${dropdownValue.value}/${date}.${ext}")
                .putFile(file);
            String UrlImage = await storage
                .ref("${dropdownValue.value}/${date}.${ext}")
                .getDownloadURL();

            await firestore.collection("task").doc(date).set({
              "uid": uid,
              "user": username,
              "kegiatan": kegiatan.text,
              "opsi": dropdownValue.value,
              "qty": qty.text,
              "photoUrl": UrlImage,
              "createdAt": date
            });
          } else {
            await firestore.collection("task").doc(date).set({
              "uid": uid,
              "user": username,
              "kegiatan": kegiatan.text,
              "opsi": dropdownValue.value,
              "qty": qty.text,
              "createdAt": date
            });
          }

          Get.offAllNamed(Routes.HOME);
          SnackbarFunction.snackBarSuccess("Berhasil menambah kegiatan");
        } else {
          SnackbarFunction.snackBarError("Gagal menambah kegiatan");
        }
      } catch (e) {
        SnackbarFunction.snackBarError("Gagal menambah kegiatan");
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
