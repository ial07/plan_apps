import 'package:get/get.dart';

import 'controller.dart';

class EditPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPlanController>(
      () => EditPlanController(),
    );
  }
}
