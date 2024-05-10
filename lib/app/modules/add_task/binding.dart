import 'package:get/get.dart';

import 'controller.dart';

class AddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaskController>(
      () => AddTaskController(),
    );
  }
}
