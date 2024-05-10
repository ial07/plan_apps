import 'package:get/get.dart';

import 'controller.dart';

class EditTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTaskController>(
      () => EditTaskController(),
    );
  }
}
