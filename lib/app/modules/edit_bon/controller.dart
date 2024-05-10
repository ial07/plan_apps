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

class EditBonController extends GetxController with MainController {
  Map<String, dynamic> data = Get.arguments;
  final f = NumberFormat();
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
                .collection("bon")
                .where("createdAt", isEqualTo: data["createdAt"])
                .get()
                .then((value) {
              value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection("bon")
                    .doc(element.id)
                    .update({
                  "keterangan": keterangan.text,
                  "status": dropdownValue.value,
                  "amount": double.parse(Amount),
                  "photoUrl": UrlImage,
                  "UpdatedAt": dates
                });
              });
            });
          } else {
            await firestore
                .collection("bon")
                .where("createdAt", isEqualTo: data["createdAt"])
                .get()
                .then((value) {
              value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection("bon")
                    .doc(element.id)
                    .update({
                  "keterangan": keterangan.text,
                  "status": dropdownValue.value,
                  "amount": double.parse(Amount),
                  "UpdatedAt": dates
                });
              });
            });
          }

          Get.offAllNamed(Routes.LISTBON);
          SnackbarFunction.snackBarSuccess("Berhasil mengedit bon");
        } else {
          SnackbarFunction.snackBarError("Gagal mengedit bon");
        }
      } catch (e) {
        SnackbarFunction.snackBarError("Gagal mengedit bon");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    keterangan.text = data["keterangan"];
    harga.text = "Rp. ${f.format(data["amount"])}";
    dropdownValue.value = data["status"];
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
