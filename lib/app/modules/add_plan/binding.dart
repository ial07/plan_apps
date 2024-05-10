import 'package:get/get.dart';

import 'controller.dart';

class AddPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPlanController>(
      () => AddPlanController(),
    );
  }
}
