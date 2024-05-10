import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';

class AddBonController extends GetxController with MainController {
  TextEditingController keterangan = TextEditingController();
  TextEditingController harga = TextEditingController();
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
    var Amount = harga.text.replaceAll("Rp. ", "").replaceAll(".", "");
    isLoading.value = true;
    if (keterangan.text.isEmpty) {
      isLoading.value = false;
      error["keterangan"] = "Harap isi keterangan";

      Future.delayed(Duration(seconds: 5), () {
        error["keterangan"] = null;
      });
    }
    if (dropdownValue.value.isEmpty) {
      isLoading.value = false;
      error["opsi"] = "Harap isi opsi";

      Future.delayed(Duration(seconds: 5), () {
        error["opsi"] = null;
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
        dropdownValue.value.isNotEmpty) {
      try {
        if (auth.currentUser != null) {
          var dates = DateTime.now().toIso8601String();
          String uid = auth.currentUser!.uid;
          String username = getFirstWord(auth.currentUser!.displayName!);
          if (image.value != null) {
            File file = File(image!.value!.path);
            String ext = image!.value!.name.split(".").last;

            await storage
                .ref("${dropdownValue.value}/${dates}.${ext}")
                .putFile(file);
            String UrlImage = await storage
                .ref("${dropdownValue.value}/${dates}.${ext}")
                .getDownloadURL();

            await firestore.collection("bon").doc(dates).set({
              "uid": uid,
              "user": username,
              "keterangan": keterangan.text,
              "status": dropdownValue.value,
              "amount": double.parse(Amount),
              "photoUrl": UrlImage,
              "createdAt": dates,
            });
          } else {
            await firestore.collection("bon").doc(dates).set({
              "uid": uid,
              "user": username,
              "keterangan": keterangan.text,
              "status": dropdownValue.value,
              "amount": double.parse(Amount),
              "createdAt": dates,
            });
          }
          Get.offAllNamed(Routes.LISTBON);
          SnackbarFunction.snackBarSuccess("Berhasil menambah bon");
        } else {
          SnackbarFunction.snackBarError("Gagal menambah bon");
        }
      } catch (e) {
        SnackbarFunction.snackBarError("Gagal menambah bon");
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
