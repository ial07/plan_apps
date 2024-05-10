import 'package:get/get.dart';

import 'controller.dart';

class EditModalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditModalController>(
      () => EditModalController(),
    );
  }
}
