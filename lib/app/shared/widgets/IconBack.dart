import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconBack extends StatelessWidget {
  const IconBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      splashRadius: 20,
      icon: Icon(
        Icons.arrow_back,
        size: 27,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }
}
