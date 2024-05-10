import 'package:get/get.dart';

import 'controller.dart';

class EditBonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditBonController>(
      () => EditBonController(),
    );
  }
}
