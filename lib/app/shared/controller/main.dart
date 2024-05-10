import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plan_apps/app/modules/add_task/view.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MainController {
  RxInt pageIndex = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool getMaster() {
    if (auth.currentUser!.email! == "ialilham77@gmail.com") {
      return true;
    }
    return false;
  }

  bool getUid(String uid) {
    if (auth.currentUser!.uid! == uid) {
      return true;
    }
    return false;
  }

  void changePage(int i) async {
    pageIndex.value = i;
    switch (i) {
      case 0:
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        Get.offAllNamed(Routes.LISTPLAN);
        break;
      case 2:
        Get.bottomSheet(
          AddTaskView(),
          isScrollControlled: true,
          barrierColor: Colors.black38,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        );
        break;
      case 3:
        Get.offAllNamed(Routes.LISTMODAL);
        break;
      case 4:
        Get.offAllNamed(Routes.LISTBON);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  String getFirstWord(String text) {
    // Memisahkan string menjadi array berdasarkan spasi
    List<String> words = text.split(' ');

    // Mengambil kata pertama dari array
    String firstWord = words[0];

    // Mengembalikan kata pertama
    return firstWord;
  }
}
