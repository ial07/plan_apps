import 'package:get/get.dart';

import 'controller.dart';

class AddBonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBonController>(
      () => AddBonController(),
    );
  }
}
