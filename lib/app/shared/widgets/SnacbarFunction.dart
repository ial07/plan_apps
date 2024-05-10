import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plan_apps/app/shared/constants/colors.dart';

class SnackbarFunction {
  static snackBarError(String error) {
    Get.snackbar(
      "Error",
      "$error",
      icon: Icon(Icons.warning, color: ColorConstants.white),
      backgroundColor: ColorConstants.Danger,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: ColorConstants.white,
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static snackBarSuccess(String success) {
    Get.snackbar(
      "Success",
      "$success",
      icon: Icon(Icons.check, color: ColorConstants.white),
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: ColorConstants.white,
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
