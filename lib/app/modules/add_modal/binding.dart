import 'package:get/get.dart';

import 'controller.dart';

class AddModalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddModalController>(
      () => AddModalController(),
    );
  }
}
